# Design Guidelines for Asthana Live

## Design Approach

**Selected Approach:** Design System (Material Design) with Social Platform Inspiration

**Justification:** Asthana Live is a real-time, data-intensive application requiring consistent patterns for status indicators, live updates, and user interactions. Material Design provides excellent foundations for real-time feedback, elevation systems for card hierarchies, and responsive grids. We'll draw additional inspiration from LinkedIn's professional profile aesthetic and WhatsApp's presence indicators for the social/presence features.

**Key Design Principles:**
- Real-time clarity: Every status change should be immediately visible
- Spatial efficiency: Dense information without clutter
- Social warmth: Professional yet approachable for profile interactions
- Action-oriented: Clear pathways to WhatsApp, Gmail, maps, and galleries

---

## Core Design Elements

### A. Typography

**Font Family:** Inter (primary), Roboto (fallback)
- **Headers:** Inter, weights 600-700
- **Body text:** Inter, weight 400
- **Captions/metadata:** Inter, weight 300-400

**Type Scale:**
- Hero/Page Titles: text-4xl (36px) font-semibold
- Section Headers: text-2xl (24px) font-semibold
- Card Titles/Names: text-lg (18px) font-medium
- Body/Descriptions: text-base (16px) font-normal
- Metadata/Timestamps: text-sm (14px) font-light
- Button Labels: text-sm (14px) font-medium uppercase tracking-wide

### B. Layout System

**Spacing Primitives:** Use Tailwind units of 2, 4, 6, 8, 12, 16, 20
- Micro spacing (within components): p-2, gap-2
- Component padding: p-4, p-6
- Section spacing: py-8, py-12
- Major gaps: gap-4, gap-6, gap-8
- Page margins: px-4 (mobile), px-8 (tablet), px-16 (desktop)

**Container Strategy:**
- Max width: max-w-7xl (1280px) for main content
- Cards: rounded-2xl with shadow-md
- Modals: max-w-2xl (672px) centered

**Grid System:**
- Profile Cards: grid-cols-2 (mobile), md:grid-cols-3 (tablet), lg:grid-cols-4 (desktop)
- Gallery: grid-cols-2 (mobile), md:grid-cols-3 (tablet), lg:grid-cols-4 (desktop)
- Gap consistency: gap-4 (mobile), gap-6 (desktop)

---

## Component Library

### Navigation Header
**Structure:**
- Full-width container with max-w-7xl inner wrapper
- Height: h-16 (64px)
- Layout: Flex row with space-between alignment
- Left section: Logo/brand (text-xl font-bold) + app name
- Center section: Search bar (flex-1 max-w-md) with icon prefix
- Right section: Filter toggle button + user avatar dropdown

**Search Bar:**
- Rounded-full with px-4 py-2
- Icon (search) left-aligned with mr-2
- Placeholder text-sm
- Focus ring with ring-2 offset

### Profile Cards
**Card Container:**
- Aspect ratio: Slightly taller than square (aspect-[4/5])
- Padding: p-6
- Border: rounded-2xl
- Elevation: shadow-md with hover:shadow-lg transition
- Background: Use subtle gradient or solid depending on theme

**Card Structure (top to bottom):**
1. **Avatar Section (relative positioning):**
   - Avatar: w-20 h-20 (80px), rounded-full, centered
   - Online badge: Absolute positioning bottom-0 right-0, w-4 h-4 rounded-full with ring-2 ring-white
   
2. **User Info (mt-4):**
   - Name: text-lg font-medium, truncate, text-center
   - Email: text-sm, truncate, text-center, mt-1
   - Bio: text-sm, line-clamp-2, text-center, mt-2
   
3. **Status Row (mt-4):**
   - Last active: text-xs, centered
   - Last location summary: text-xs, centered, mt-1
   
4. **Action Buttons (mt-6, grid-cols-2, gap-2):**
   - 4 buttons in 2x2 grid
   - Each button: p-2, rounded-lg, flex flex-col items-center gap-1
   - Icon: w-5 h-5
   - Label: text-xs font-medium
   - Hover state: subtle scale transform

5. **Owner Edit Button (mt-4):**
   - Full width, py-2, rounded-lg
   - Text-sm font-medium

### Modals (EditProfile, Map, Gallery)
**Modal Overlay:**
- Fixed inset-0 with backdrop blur
- z-50 positioning
- Flex centering: items-center justify-center
- Padding: p-4

**Modal Container:**
- Max-w-2xl (edit), max-w-4xl (gallery), max-w-3xl (map)
- Background with rounded-2xl
- Shadow-2xl elevation
- Max-height: max-h-[90vh] with overflow-y-auto

**Modal Header:**
- Flex row with items-center justify-between
- Padding: p-6 with border-b
- Title: text-2xl font-semibold
- Close button: w-8 h-8 rounded-full, flex items-center justify-center

**Modal Body:**
- Padding: p-6
- Forms: space-y-6 (stacked inputs)

### Edit Profile Modal
**Form Inputs (each):**
- Label: text-sm font-medium, mb-2
- Input: w-full px-4 py-3 rounded-lg border with focus:ring-2
- Textarea (bio): min-h-24 (96px)
- Photo upload area: Aspect-square, dashed border, rounded-lg, flex items-center justify-center

**Action Buttons (modal footer):**
- Flex row gap-4, justify-end
- Cancel: px-6 py-2.5 rounded-lg
- Save: px-6 py-2.5 rounded-lg font-medium

### Map Modal
**Map Container:**
- Height: h-96 (384px) for last location view
- Height: h-[500px] for live tracking view
- Rounded-lg overflow-hidden
- Margin: mb-4

**Controls Row:**
- Flex row with gap-4, justify-between
- Toggle "Follow Live": Switch component with label text-sm
- "Open in Google Maps": Button with external link icon

### Gallery Modal
**Gallery Grid:**
- Grid-cols-2 (mobile), md:grid-cols-3 (tablet)
- Gap-4
- Each item: Aspect-square, rounded-lg overflow-hidden, relative

**Gallery Item:**
- Image: object-cover w-full h-full
- Hover overlay: Absolute inset-0 with backdrop blur showing metadata
- Metadata (on hover): Timestamp text-xs + "Uploaded from" link text-xs underline

**Upload Section (top of modal):**
- Border dashed, rounded-lg, p-8
- Height: h-48 (192px)
- Flex column items-center justify-center
- Icon: w-12 h-12
- Upload text: text-sm font-medium
- Progress bar (when uploading): w-full h-2 rounded-full

### Status Indicators
**Online Badge:**
- Size: w-3 h-3 to w-4 h-4
- Position: Absolute on avatar (bottom-right)
- Border ring: ring-2 ring-white or ring-background
- Animation: pulse for online status

**Last Active Text:**
- Format: "Active now" | "Active 5m ago" | "Last seen 2h ago"
- Text size: text-xs
- Subtle styling to differentiate from primary text

---

## Images

**Profile Avatars:**
- Use placeholder services (e.g., ui-avatars.com with user initials)
- For demo: Include 4 diverse avatar images representing different users
- Fallback: Letter avatars with user's initials on solid background

**Gallery Photos:**
- Use placeholder images from unsplash.com or picsum.photos
- Minimum 4 sample photos per demo user
- Images should represent various contexts (indoor, outdoor, travel, work)
- Each image needs associated geolocation data for demo

**No Hero Image:** This is a functional application, not a marketing page. Skip traditional hero sections in favor of immediate utility (search/filter + profile grid).

---

## Accessibility & Interaction

**Focus Management:**
- All interactive elements: focus:ring-2 focus:ring-offset-2
- Modal open: trap focus within modal, prevent body scroll
- Modal close: return focus to trigger element

**Button States:**
- Default: Base styling
- Hover: Subtle scale (scale-105) or shadow increase
- Active: Slight scale down (scale-95)
- Disabled: Reduced opacity (opacity-50), cursor-not-allowed

**Aria Labels:**
- All icon buttons: aria-label descriptive text
- Status badges: aria-live="polite" for dynamic updates
- Modals: role="dialog", aria-labelledby for title

**Touch Targets:**
- Minimum 44x44px (h-11 w-11) for all tappable elements
- Adequate spacing between action buttons (gap-2 minimum)

---

## Animation Strategy

**Use Sparingly:**
- Status changes: Subtle pulse animation for online badge
- Modal entry: Fade in + scale from 95% to 100% (duration-200)
- Card hover: Shadow elevation change (transition-shadow)
- Loading states: Spinner or skeleton screens, no elaborate animations

**Avoid:**
- Scroll-triggered animations
- Parallax effects
- Complex page transitions