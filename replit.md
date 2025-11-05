# Asthana Live

## Overview

Asthana Live is a real-time location sharing and profile management web application designed for teams to stay connected. The platform enables users to share live location updates, manage professional profiles, upload geotagged photos to galleries, and interact through WhatsApp and Gmail integrations. Built with a modern full-stack architecture, the application emphasizes real-time data synchronization, responsive design, and social connectivity.

## User Preferences

Preferred communication style: Simple, everyday language.

## Recent Features Added (November 2024)

### Office Gallery (Universal Gallery)
- **Universal Photo View**: Centralized gallery showing all co-workers' uploaded photos
- **Timeline Organization**: Photos grouped by date with headers:
  - "Today's Photos" for photos uploaded today
  - "Yesterday's Photos" for photos uploaded yesterday
  - Full date format (e.g., "November 3, 2025") for older photos
  - Each date section shows photo count for that day
- **Pagination System**:
  - 80 photos per page maximum
  - Automatic page creation when 81st photo is uploaded
  - Previous/Next navigation buttons
  - Page indicator shows "Page X of Y" in header
  - Timeline context preserved across pages (e.g., "Today" photos spanning multiple pages maintain header)
- **Time Display**: Each photo shows upload time in 12-hour format (e.g., "2:30 PM")
- **Smart Date Handling**: Automatic conversion of timestamps to Date objects for reliable formatting
- **Uploader Attribution**: On hover, shows uploader's profile picture and name in top-right corner with backdrop blur
- **Responsive Grid**: 2 columns (mobile), 3 (tablet), 4 (desktop)
- **Full Photo Features**: Each photo supports:
  - View in Zoom (full size)
  - View on Map (if location available)
  - Delete Photo (owner only)
- **Photo Detail Modal**: Desktop-sized popup (max-w-2xl, max-h-85vh) for viewing photos without covering scrollbar
- **Professional UI**: Dark gradient overlay at bottom for time visibility, backdrop blur for uploader info
- **Easy Access**: Accessible via "Office Gallery" button in header
- **Filter Preserved**: Online-only filter available via separate button alongside Office Gallery
- **State Management**: Page reset logic handles gallery updates to prevent empty page states

### Group Messaging System
- **Floating Action Button**: Colorful gradient button (blue to purple) in bottom-right corner
- **Notification Badge**: Red badge displaying unread message count (auto-resets when modal opens)
- **Group Chat Modal**: Real-time messaging interface with message history, timestamps, and send functionality
- **Message Display**: Shows user avatars, names, timestamps, and message content in a scrollable list

### Settings Modal
- **Auto-Delete Configuration**: Users can configure automatic deletion of old photos
- **Enable/Disable Toggle**: Switch to turn auto-delete on or off (default: enabled)
- **Day Count Configuration**: Input field to set number of days (default: 45)
- **Persistent Settings**: Settings saved in Home.tsx state and persist across modal close/reopen
- **Automatic Cleanup**: useEffect runs when settings change to delete photos older than threshold
- **Logging**: Console logs show count of auto-deleted photos for visibility

### Gallery Management
- **Delete Photo Button**: Red destructive button in gallery modal (below "View on Map")
- **Owner-Only Access**: Delete button only appears for user's own photos
- **Real-Time Updates**: Gallery count updates immediately on both modal and profile cards
- **Persistent Deletion**: Photos remain deleted across modal close/reopen cycles
- **State Management**: Uses immutable state updates to prevent mutation of shared references

### Profile Management
- **Delete Profile Option**: Added to user dropdown menu (below "Log out")
- **Destructive Styling**: Red text to indicate dangerous action
- **Confirmation Dialog**: AlertDialog warns user about permanent data deletion
- **Data Impact**: Informs user that photos, messages, and all data will be removed

### Technical Implementation
- **Component Files**: 
  - GroupMessagingModal.tsx (group chat interface)
  - SettingsModal.tsx (auto-delete configuration)
  - OfficeGalleryModal.tsx (NEW - universal gallery view)
  - Updated: GalleryModal.tsx (delete photo button)
  - Updated: Header.tsx (Office Gallery button, settings menu item)
  - Updated: Dashboard.tsx (dynamic gallery counts, Office Gallery integration)
  - Updated: Home.tsx (gallery state management, deletion handlers)
- **State Management**: 
  - Galleries state managed in Home.tsx with immutable updates
  - Settings state (autoDeleteEnabled, autoDeleteDays) in Home.tsx
  - Props passed down through Dashboard to modals
  - Dynamic gallery count computed from actual state
- **UI Components**: Uses shadcn/ui AlertDialog, Switch, Badge, Button components
- **Test Coverage**: All features have comprehensive e2e test coverage with data-testid attributes
- **Data Flow**:
  - Home.tsx manages galleries useState
  - handleDeletePhoto creates new state with filtered array
  - useEffect auto-deletes based on settings
  - Dashboard computes galleryCount={galleries[user.uid]?.length || 0}
  - ProfileCard displays synchronized count

## System Architecture

### Frontend Architecture

**Framework & Build System**
- React 18+ with TypeScript for type-safe component development
- Vite as the build tool and development server
- Wouter for lightweight client-side routing
- TanStack Query (React Query) for server state management and caching

**UI Component System**
- shadcn/ui components built on Radix UI primitives
- Tailwind CSS for utility-first styling with custom design tokens
- Material Design-inspired design system ("new-york" style)
- Responsive grid layouts: 2 columns (mobile), 3 columns (tablet), 4 columns (desktop)
- Component library includes modals, carousels, forms, and navigation elements

**State Management**
- React Query for async data fetching and caching with configured stale-time policies
- Local React state (useState) for UI interactions and form handling
- QueryClient configured to not refetch on window focus or intervals

**Key UI Patterns**
- Carousel-based pagination system (20 cards per carousel, 5 carousels per page)
- Profile cards with avatar, online status indicators, and action buttons
- Modal-based workflows for editing profiles, viewing maps, and managing galleries
- Real-time status badges and timestamp displays using date-fns

### Backend Architecture

**Server Framework**
- Express.js as the HTTP server framework
- Node.js runtime with ES modules (type: "module")
- TypeScript for type safety across the stack
- Custom middleware for JSON parsing with raw body preservation

**Database Layer**
- Drizzle ORM for type-safe database operations
- PostgreSQL as the primary database (via Neon serverless driver)
- Schema-first approach with Drizzle Kit for migrations
- Shared schema definitions between client and server (`shared/schema.ts`)

**Data Storage Strategy**
- In-memory storage implementation (MemStorage) as the development interface
- IStorage interface pattern for potential database backend swapping
- User management with UUID-based primary keys
- Username-based lookup and user creation methods

**Authentication & Authorization**
- Firebase Authentication planned for user management (email/password + Google OAuth)
- JWT token-based session management expected
- Password reset and remember-me functionality designed

**Real-time Communication**
- Socket.IO server integration planned for live location updates
- Event-driven architecture for user presence tracking (online/offline status)
- Socket authentication via Firebase ID token verification
- Real-time broadcasts for location updates and user status changes

**API Design**
- RESTful API structure with `/api` prefix routing
- Request/response logging middleware with duration tracking
- JSON response capture for debugging and monitoring
- Error handling with status code-based responses

### External Dependencies

**Firebase Services**
- Firebase Authentication for user authentication (email/password, Google OAuth)
- Firebase Firestore for real-time user data synchronization
  - Collections: `users`, `presence`
  - Fields: uid, displayName, email, photoURL, bio, whatsapp, gmail, online status, lastActive, lastLocation, gallery
- Firebase Storage for photo uploads (`users/{uid}/gallery/{filename}`)
- Firebase Admin SDK for server-side token verification
- Firebase client config embedded for demo/development purposes

**Google Maps Platform**
- Google Maps JavaScript API for interactive map displays
- Google Geocoding API for reverse geocoding (location → place names)
- Places library integration for location-based features
- API key: `AIzaSyBnREfFU6wAmMMQOWIU8Fld2upjgywk-t8` (demo key, should be environment variable in production)

**Third-Party Communication Services**
- WhatsApp integration via direct URL scheme (`wa.me/{phone}`)
- Gmail integration via mailto links

**UI Component Libraries**
- Radix UI primitives (dialog, dropdown, popover, tooltip, etc.)
- Embla Carousel for horizontal scrolling galleries
- React Hook Form with Zod validation (@hookform/resolvers)
- Lucide React for icon components
- React Icons (react-icons/fa, react-icons/si) for social icons

**Development Tools**
- Replit-specific plugins for development banner and error overlays
- tsx for TypeScript execution in development
- esbuild for production bundling
- PostCSS with Tailwind and Autoprefixer

**Session Management**
- connect-pg-simple for PostgreSQL-based session storage
- Session persistence planned for remember-me functionality

**Date Handling**
- date-fns for relative timestamps and date formatting

**Styling & Design**
- class-variance-authority for component variant management
- clsx and tailwind-merge for conditional class composition
- Custom CSS variables for theme colors and elevation states
- Dark mode support via CSS class strategy