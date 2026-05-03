<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>High-Altitude Trekking - Thoughts of Nomads</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "primary-fixed-dim": "#bbc4f3",
                      "surface-container-highest": "#e1e3e4",
                      "on-tertiary-fixed": "#2a1800",
                      "on-error-container": "#93000a",
                      "tertiary-fixed": "#ffddb5",
                      "tertiary": "#2a1800",
                      "tertiary-fixed-dim": "#ffb957",
                      "on-tertiary-container": "#d18900",
                      "surface-container-high": "#e7e8e9",
                      "surface-container-low": "#f3f4f5",
                      "on-surface-variant": "#45464e",
                      "on-primary-fixed-variant": "#3b456c",
                      "outline": "#76767f",
                      "secondary-fixed": "#ffdad4",
                      "on-secondary": "#ffffff",
                      "surface-tint": "#535c85",
                      "inverse-surface": "#2e3132",
                      "surface-container-lowest": "#ffffff",
                      "primary-fixed": "#dce1ff",
                      "on-background": "#191c1d",
                      "inverse-on-surface": "#f0f1f2",
                      "surface-variant": "#e1e3e4",
                      "tertiary-container": "#462b00",
                      "background": "#f8f9fa",
                      "on-secondary-fixed-variant": "#82261b",
                      "surface-dim": "#d9dadb",
                      "outline-variant": "#c6c5cf",
                      "on-tertiary": "#ffffff",
                      "surface": "#f8f9fa",
                      "on-error": "#ffffff",
                      "surface-bright": "#f8f9fa",
                      "surface-container": "#edeeef",
                      "secondary": "#a23d30",
                      "on-primary-fixed": "#0e193e",
                      "on-primary": "#ffffff",
                      "on-secondary-container": "#731a11",
                      "inverse-primary": "#bbc4f3",
                      "secondary-fixed-dim": "#ffb4a8",
                      "error-container": "#ffdad6",
                      "on-tertiary-fixed-variant": "#643f00",
                      "on-primary-container": "#8c96c2",
                      "on-secondary-fixed": "#410000",
                      "secondary-container": "#fd8270",
                      "primary-container": "#242e54",
                      "primary": "#0e193e",
                      "on-surface": "#191c1d",
                      "error": "#ba1a1a"
              },
              "borderRadius": {
                      "DEFAULT": "0.125rem",
                      "lg": "0.25rem",
                      "xl": "0.5rem",
                      "full": "0.75rem"
              },
              "spacing": {
                      "base": "8px",
                      "margin-desktop": "48px",
                      "container-max": "1280px",
                      "margin-mobile": "16px",
                      "gutter": "24px",
                      "section-gap": "80px"
              },
              "fontFamily": {
                      "label-caps": [
                              "Work Sans"
                      ],
                      "body-lg": [
                              "Work Sans"
                      ],
                      "headline-md": [
                              "Epilogue"
                      ],
                      "display-lg": [
                              "Epilogue"
                      ],
                      "headline-lg": [
                              "Epilogue"
                      ],
                      "body-md": [
                              "Work Sans"
                      ]
              },
              "fontSize": {
                      "label-caps": [
                              "12px",
                              {
                                      "lineHeight": "1.0",
                                      "letterSpacing": "0.1em",
                                      "fontWeight": "600"
                              }
                      ],
                      "body-lg": [
                              "18px",
                              {
                                      "lineHeight": "1.6",
                                      "fontWeight": "400"
                              }
                      ],
                      "headline-md": [
                              "24px",
                              {
                                      "lineHeight": "1.3",
                                      "fontWeight": "600"
                              }
                      ],
                      "display-lg": [
                              "48px",
                              {
                                      "lineHeight": "1.1",
                                      "letterSpacing": "-0.02em",
                                      "fontWeight": "700"
                              }
                      ],
                      "headline-lg": [
                              "32px",
                              {
                                      "lineHeight": "1.2",
                                      "fontWeight": "600"
                              }
                      ],
                      "body-md": [
                              "16px",
                              {
                                      "lineHeight": "1.5",
                                      "fontWeight": "400"
                              }
                      ]
              }
      },
          },
        }
      </script>
</head>
<body class="bg-background text-on-background font-body-md antialiased flex flex-col min-h-screen">
<!-- TopNavBar -->
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<main class="flex-grow w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-8 flex flex-col gap-12">
<!-- Header Section -->
<section class="flex flex-col gap-2">
<nav class="flex text-sm text-outline mb-2">
<ol class="flex items-center space-x-1.5">
<li><a class="hover:text-primary transition-colors" href="<%=request.getContextPath()%>/">Home</a></li>
<li><span class="material-symbols-outlined text-xs">chevron_right</span></li>
<li><a class="hover:text-primary transition-colors" href="<%=request.getContextPath()%>/category">Categories</a></li>
<li><span class="material-symbols-outlined text-xs">chevron_right</span></li>
<li class="text-on-background font-medium">Trekking</li>
</ol>
</nav>
<h1 class="font-headline-lg text-headline-lg text-primary-container">Exploring: High-Altitude Trekking</h1>
<p class="font-body-md text-body-md text-on-surface-variant">Showing 12 journeys found in this category.</p>
</section>
<!-- Refiner Bar -->
<section class="flex flex-col md:flex-row gap-3 justify-between items-center bg-surface-container-lowest p-3 border border-surface-variant rounded-lg">
<div class="relative w-full md:w-1/3">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline text-sm">search</span>
<input class="w-full pl-9 pr-3 py-1.5 border border-surface-variant rounded focus:border-primary-container focus:ring-1 focus:ring-primary-container text-sm text-on-background outline-none transition-colors bg-transparent" placeholder="Search trekking routes..." type="text"/>
</div>
<div class="flex gap-3 w-full md:w-auto">
    <div class="relative w-full md:w-auto">
        <select class="w-full md:w-48 px-3 py-1.5 border border-surface-variant rounded focus:border-primary-container focus:ring-1 focus:ring-primary-container text-sm text-on-background outline-none transition-colors bg-transparent appearance-none">
            <option>Sort By: Newest</option>
            <option>Sort By: Popular</option>
            <option>Sort By: Difficulty</option>
        </select>
        <span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2 text-outline text-sm pointer-events-none">expand_more</span>
    </div>
    <div class="relative w-full md:w-auto">
        <select class="w-full md:w-48 px-3 py-1.5 border border-surface-variant rounded focus:border-primary-container focus:ring-1 focus:ring-primary-container text-sm text-on-background outline-none transition-colors bg-transparent appearance-none">
            <option>Author: All</option>
            <option>Elena Rostova</option>
            <option>Marcus Chen</option>
        </select>
        <span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2 text-outline text-sm pointer-events-none">expand_more</span>
    </div>
</div>
</section>
<!-- Results Grid -->
<section class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
<!-- Card 1 -->
<article class="flex flex-col bg-surface-container-lowest border border-surface-variant rounded-lg overflow-hidden group hover:shadow-[0_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
<div class="aspect-w-16 aspect-h-10 relative overflow-hidden bg-surface-container">
<img alt="Mountain Peak" class="object-cover w-full h-full group-hover:scale-105 transition-transform duration-500" data-alt="A breathtaking view of a snow-capped mountain peak dominating the skyline, surrounded by dramatic, rocky terrain under a crisp, clear blue sky. The lighting is bright and high-contrast, emphasizing the rugged textures of the stone and the pristine white snow. The scene is shot from a slightly low angle, enhancing the majesty of the peak. The overall mood is adventurous, awe-inspiring, and slightly cold, fitting a premium travel editorial aesthetic." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAqZW4EPym-BrQ1VePHJS0yHpD_OIDcVXGZDq6jSwa5Cq65HVdiJ0A7yabuvafG59GAWkylOdaWlYddw2RBqFflzlgzJXQypvvx1a5jSMGFtqAKgZyPltMXWYcIroJVrFukSKm_qWyFVApXYeRI-0zJY0nQqIq59tazM11EBYvWrojqK-4dMX9ezyA_1jEaMcsPAmjC7FRUt5Rj4RXujRtuTLatZsgEnVtJo9ywM9J60IB5F35X-zMT1QDgz-apbrIadb5Kg7Vf-kk"/>
</div>
<div class="p-4 flex flex-col gap-3 flex-grow">
<span class="inline-block bg-surface-container-highest text-tertiary-container px-2 py-0.5 rounded text-[10px] font-semibold tracking-wider self-start">TREKKING</span>
<h2 class="font-headline-md text-lg font-semibold text-on-background group-hover:text-primary-container transition-colors line-clamp-2">The Silence of the Annapurna Circuit</h2>
<p class="font-body-md text-sm text-on-surface-variant line-clamp-2 flex-grow">A fourteen-day journey through changing climates, ancient monasteries, and the sheer scale of the Himalayas.</p>
<div class="flex items-center gap-2 mt-auto pt-3 border-t border-surface-variant">
<div class="w-6 h-6 rounded-full bg-surface-dim overflow-hidden">
<img alt="Author" class="w-full h-full object-cover" data-alt="A close-up portrait of a female travel writer with wind-swept hair, wearing a high-performance jacket. The lighting is soft, natural daylight, casting subtle shadows on her face. The background is a slightly blurred, bright outdoor setting. The mood is professional, adventurous, and authentic, aligning with a high-end editorial style." src="https://lh3.googleusercontent.com/aida-public/AB6AXuBwVkPSyvFyVFz3KO53Tn37Ci_k7rwoOzsdvriJ04hWPzMDd0dJYjPoDVZuw5MfdttEmfZkoExKc0V29qLJJIPxMMkurADsB8mxYSs6YPQcQYG9AOwq09mcuuD3SnQ8QWRpuqKK1NZSnFF4VFi8XNvMLxCTGjIhS2g3MjJvHop4oWpxx-nL3CoLQEx4m7saE7_aCTsk8xDTIYsmXHpuEs0J-cz1jigKTRtdippvQnuKlzwlf4zURdPdGjL1m1GeZaj_HbAshlGLQkI"/>
</div>
<div class="flex flex-col">
<span class="font-body-md text-xs font-semibold text-on-background">Elena Rostova</span>
<span class="font-body-md text-[10px] text-outline">Oct 12, 2023</span>
</div>
</div>
</div>
</article>
<!-- Card 2 -->
<article class="flex flex-col bg-surface-container-lowest border border-surface-variant rounded-lg overflow-hidden group hover:shadow-[0_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
<div class="aspect-w-16 aspect-h-10 relative overflow-hidden bg-surface-container">
<img alt="Hikers on trail" class="object-cover w-full h-full group-hover:scale-105 transition-transform duration-500" data-alt="A wide shot showing two hikers trekking along a narrow, winding mountain path. The landscape is vast, featuring deep valleys and distant, misty peaks. The lighting is early morning, casting long, dramatic shadows and painting the scene in cool, blue and gray tones. The mood is solitary, challenging, and expansive, perfect for a high-altitude adventure narrative in a modern editorial context." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDgC0RSiVRmYRr7G9r4O0V5DnUIKWy2BnMXHG0IYZgFjEUcVa0s9s1h4Mwl-d-BVvoE7dbil4dvfuxPp4wneIoLSvm1HlA7cfgKpHsiONSELZhPVysUpnQ8zQ1IaeDJQg01_DmOoCUEZwjZu8QZTxot0TfW3WW78QUgMHfFb4fPLX-GBIve3mqmeyt6FefLlHHPZzsagIaD0PYoB-Q1R4Rt53Yvd0xndrmrysJvPFLqvCNx7YgDalE6Pg4oMcxhUHNTRS5aOP3jGmE"/>
</div>
<div class="p-4 flex flex-col gap-3 flex-grow">
<span class="inline-block bg-surface-container-highest text-tertiary-container px-2 py-0.5 rounded text-[10px] font-semibold tracking-wider self-start">TREKKING</span>
<h2 class="font-headline-md text-lg font-semibold text-on-background group-hover:text-primary-container transition-colors line-clamp-2">Navigating the Torres del Paine</h2>
<p class="font-body-md text-sm text-on-surface-variant line-clamp-2 flex-grow">Wind, rain, and unexpected clarity at the end of the world in Patagonia's most demanding circuit.</p>
<div class="flex items-center gap-2 mt-auto pt-3 border-t border-surface-variant">
<div class="w-6 h-6 rounded-full bg-surface-dim overflow-hidden">
<img alt="Author" class="w-full h-full object-cover" data-alt="A portrait of a male adventurer in his 30s, looking off-camera with a contemplative expression. He is wearing a rugged canvas jacket. The lighting is diffused, perhaps under a cloudy sky, creating a moody, atmospheric portrait. The background is a muted, out-of-focus natural texture. The aesthetic is raw, grounded, and fitting for a premium travel magazine." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCL_ewb1DxEPxTQFXFoEx7IBvSDzKav-YIlV0qQ2ZIo81Zzg50mEzt7VmF-DSvtXV-CgS9AtJAvJ75XR3Nju-LZovvOI-6DsNtUzn7eX8LLp1sh41vx5fUeDjPB7jnW5Ver-GgOnFwZoxNJrJES4_1C-uITwuqtNmk88vVttLyngO-kWOsHkkKa8nS4iWrOCdHsbo4XvM1PbCdTkTNHNo5qOiPof7QimHrbI1zFL6Mq-9tbpcjOmRPChxL9ZIoLdhBk4MAv_zr7Wek"/>
</div>
<div class="flex flex-col">
<span class="font-body-md text-xs font-semibold text-on-background">Marcus Chen</span>
<span class="font-body-md text-[10px] text-outline">Nov 04, 2023</span>
</div>
</div>
</div>
</article>
<!-- Card 3 -->
<article class="flex flex-col bg-surface-container-lowest border border-surface-variant rounded-lg overflow-hidden group hover:shadow-[0_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
<div class="aspect-w-16 aspect-h-10 relative overflow-hidden bg-surface-container">
<img alt="Alpine Lake" class="object-cover w-full h-full group-hover:scale-105 transition-transform duration-500" data-alt="A stunning view of a crystal-clear, intensely blue alpine lake nestled between towering, jagged mountain ridges. The lighting is midday, very bright and stark, highlighting the deep blue of the water against the barren, rocky terrain. The image feels expansive and remote. The mood is serene but untamed, shot with a high-contrast, desaturated style typical of high-end outdoor photography." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDdLTgnCl40Eu4LeCK1g2lP4CWtfF-qd00R1hxWtxuFxHJdfhuBVgfIMISFnuZOZ3BLfScy1JOkuUjZo6qmf9U55OVQMKyYovtvtGgPhVnuT6WvyYfM6-RuBbtBChgAO8tS29kiAX483ltGxhx-gwTPncsb8Y6HUZccz4TS3Txxw5bgVWv9rTsZfum9y892idKBe6E9b3rtCXzgV7hj19Neu8d3soWqOzJGSI_Rnwhhe5Z7z1xKo-uvHHmsWmwVbWtsD1kpxDWPhkw"/>
</div>
<div class="p-4 flex flex-col gap-3 flex-grow">
<span class="inline-block bg-surface-container-highest text-tertiary-container px-2 py-0.5 rounded text-[10px] font-semibold tracking-wider self-start">TREKKING</span>
<h2 class="font-headline-md text-lg font-semibold text-on-background group-hover:text-primary-container transition-colors line-clamp-2">The Hidden Lakes of the Karakoram</h2>
<p class="font-body-md text-sm text-on-surface-variant line-clamp-2 flex-grow">Finding isolation and impossible colors above 4,000 meters in one of the world's least forgiving ranges.</p>
<div class="flex items-center gap-2 mt-auto pt-3 border-t border-surface-variant">
<div class="w-6 h-6 rounded-full bg-surface-dim overflow-hidden">
<img alt="Author" class="w-full h-full object-cover" data-alt="A profile portrait of a female writer with a focused expression, wearing a minimalist dark turtleneck. The lighting is stark and dramatic, with a strong directional light highlighting her features against a dark, undefined background. The mood is intellectual and intense, matching the discipline of a seasoned explorer in a modern editorial layout." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAL-wvf5VCZDn0Gb_zSOkWH8tHR2CaHniHTMmXJPpA-E4XeJrRaAD4eQdTA4t41o-e24_88UvOD80uJklsXupuoUFFmcS6lNdXVDdi6QDAMM1YDFJw08stvaNsU-JsfuvBNV_EWPn1T94Zt6m0z2fRosoUWjhRZr0w7hnmwvSz7YNusu87UXSHJw1FmF3LZg8uL_eQlOVO1qZ2fBcxkPpyKKq66IWhRTwauqCSZdmdPVKvpvPyEDBLodA6L58UM4DAErWFdjatWz_c"/>
</div>
<div class="flex flex-col">
<span class="font-body-md text-xs font-semibold text-on-background">Sarah Jenkins</span>
<span class="font-body-md text-[10px] text-outline">Dec 18, 2023</span>
</div>
</div>
</div>
</article>
<!-- Repeat for layout demonstration -->
<!-- Card 4 -->
<article class="flex flex-col bg-surface-container-lowest border border-surface-variant rounded-lg overflow-hidden group hover:shadow-[0_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
<div class="aspect-w-16 aspect-h-10 relative overflow-hidden bg-surface-container">
<img alt="Snowy ridge" class="object-cover w-full h-full group-hover:scale-105 transition-transform duration-500" data-alt="A high-altitude perspective looking down a razor-sharp, snow-covered mountain ridge leading towards distant peaks. The lighting suggests late afternoon, with long, cool shadows stretching across the snow and a warm, low-angle light hitting the ridge crest. The mood is perilous yet beautiful, emphasizing the extreme environment. The visual style is crisp, clean, and highly structured, suitable for a premium travel brand." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDgSYRIC-pj6AGe0-xYJpdDFJnhSsvl8eoBMSf1YcLQIufGuuaYPdZb8nG0RVT2zc7OXiZgFWzwgpFPQ0NVZADA0TCjbGAOD6RukQngA__aI4wbINXbWBzm1a9OzWTYrzqB1mCWY8BMqF7Yu0YvOQdTbpSvAmF93MhVs7jawkg19cdrCy61-MAvP-TwEV8vwACIg9XxN3jDuFlp890svyXxcVBX52XnCe8VBMVjTfTt2fG2b1AQlYYGRH-mVWpCBMHB55isolpnQeo"/>
</div>
<div class="p-4 flex flex-col gap-3 flex-grow">
<span class="inline-block bg-surface-container-highest text-tertiary-container px-2 py-0.5 rounded text-[10px] font-semibold tracking-wider self-start">TREKKING</span>
<h2 class="font-headline-md text-lg font-semibold text-on-background group-hover:text-primary-container transition-colors line-clamp-2">Ridge Walking the Swiss Alps</h2>
<p class="font-body-md text-sm text-on-surface-variant line-clamp-2 flex-grow">Balancing on the edge of Europe, where the views are as sharp as the drop-offs.</p>
<div class="flex items-center gap-2 mt-auto pt-3 border-t border-surface-variant">
<div class="w-6 h-6 rounded-full bg-surface-dim overflow-hidden">
<img alt="Author" class="w-full h-full object-cover" data-alt="A close-up portrait of a female travel writer with wind-swept hair, wearing a high-performance jacket. The lighting is soft, natural daylight, casting subtle shadows on her face. The background is a slightly blurred, bright outdoor setting. The mood is professional, adventurous, and authentic, aligning with a high-end editorial style." src="https://lh3.googleusercontent.com/aida-public/AB6AXuA9hJhH1T582rlWgj1Rkm_EwKfDU6s4HdqfPf625sSUoy6B9-EggbSOMqsMx6kn-uyHl2ZXOxlXQJbIwrlrmrKW32GP7qf5wBNHw8bjb3BfHVznub_cnSEnefXZh7aeA9lbdjj7qil-b5yAvKUs8cEexdQLXJ9ZjEH5O9DY2iiHV4G75xxNFreduBjIaz25PYjVfPQXBU7M9nAWpEBpIExNKthhf7Oa8L7i3N9DF1L9bltwqPdW6tOucqyUk0BQ4r3MS9Wh_hFSdfg"/>
</div>
<div class="flex flex-col">
<span class="font-body-md text-xs font-semibold text-on-background">Elena Rostova</span>
<span class="font-body-md text-[10px] text-outline">Jan 05, 2024</span>
</div>
</div>
</div>
</article>
</section>
<!-- Pagination -->
<section class="flex justify-center items-center gap-1.5 mt-6">
<button class="w-8 h-8 flex items-center justify-center rounded border border-surface-variant text-on-surface-variant hover:border-primary-container hover:text-primary-container transition-colors disabled:opacity-50" disabled="">
<span class="material-symbols-outlined text-sm">chevron_left</span>
</button>
<button class="w-8 h-8 flex items-center justify-center rounded bg-primary-container text-on-primary font-body-md text-sm font-semibold">1</button>
<button class="w-8 h-8 flex items-center justify-center rounded border border-surface-variant text-on-surface-variant hover:border-primary-container hover:text-primary-container transition-colors font-body-md text-sm">2</button>
<button class="w-8 h-8 flex items-center justify-center rounded border border-surface-variant text-on-surface-variant hover:border-primary-container hover:text-primary-container transition-colors font-body-md text-sm">3</button>
<span class="text-on-surface-variant text-sm">...</span>
<button class="w-8 h-8 flex items-center justify-center rounded border border-surface-variant text-on-surface-variant hover:border-primary-container hover:text-primary-container transition-colors">
<span class="material-symbols-outlined text-sm">chevron_right</span>
</button>
</section>
</main>
<!-- Footer -->
<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body></html>