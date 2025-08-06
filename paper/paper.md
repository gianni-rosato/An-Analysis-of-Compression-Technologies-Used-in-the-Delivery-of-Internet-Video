# **An Analysis of Compression Technologies Used in the Delivery of Internet Video** {#an-analysis-of-compression-technologies-used-in-the-delivery-of-internet-video}

A Major Qualifying Project (MQP) submitted to the faculty of

**WORCESTER POLYTECHNIC INSTITUTE**

in partial fulfillment of the requirements for the degree of Bachelor of Science

**Submitted By:**

Gianni Rosato

**Submission Date:**

\[date\]

**Submitted to:**

_**Project Advisors**_

Professor Edward Gonsalves, Professor Raha Moraffah

_This report represents the work of one or more WPI undergraduate students
submitted to the faculty as evidence of completion of a degree requirement. WPI
routinely publishes these reports on the web without editorial or peer review._

# **Abstract** {#abstract}

With internet video traffic projected to exceed 83% of all internet data in
2025, optimizing video delivery is critical for economic and environmental
sustainability. Enhanced video compression offers a primary solution, but
selecting the optimal encoding technology presents a significant challenge for
organizations. This project bridges Business and Data Science to evaluate the
economic viability and business value of different software-based video
encoders. Leveraging Rate-Distortion (RD) curve analysis as a foundational
technical metric, this research will develop a data-driven framework to assess
encoder performance not just in terms of compression efficiency and visual
quality, but also considering crucial business factors such as computational
cost, licensing fees, codec adoption maturity, and suitability for different
content types (e.g., VOD vs. UGC). The analysis will specifically investigate
how economic benefits and optimal encoder choices vary significantly across
different organizational scales and business models, from large-scale streaming
services like Netflix to user-generated content platforms like Meta to smaller
streaming enterprises. The ultimate goal is to provide organizations with
quantifiable methodology alongside actionable insights to make informed
strategic decisions about adopting video compression technologies that align
with their specific economic constraints and business objectives.

# **Acknowledgements** {#acknowledgements}

I would like to thank Luc Trudeau for his generous support throughout the
project process, acting as a consultant on a vast array of different video
resources as a seasoned professional in the video industry.

Additionally, I would like to thank my two WPI-affiliated advisors. Professor
Gonsalves and Professor Moraffah have been instrumental in supporting this
project’s completion with their expert insights and guidance.

# **Chapter 1: Introduction** {#chapter-1:-introduction}

# **Chapter 2: Literature Review** {#chapter-2:-literature-review}

## **2.1 Existing Video Compression Technologies![][image2]** {#2.1-existing-video-compression-technologies}

_Figure 1: Three-stage video streaming, processing, and playback pipeline – by
Gianni Rosato, CC BY-SA 4.0._

In this section, I will provide an overview of existing video compression
standards (codecs), their popular encoder implementations, and the metrics used
to quantify video fidelity.

The Existing Video Compression Standards (Codecs) section introduces H.264/AVC,
the industry-standard video codec used across a vast majority of the streaming
industry, and its successor, H.265/HEVC. It will also provide a brief
introduction to VP9, a royalty-free competitor to H.265. VP9 served as the basis
for AV1, a royalty-free codec designed to supersede H.264, H.265, and VP9 with
better compression and a free and open-source model. AV1 competes with H.266, a
royalty-bearing codec meant to succeed H.265.

The Video Encoder Implementations section introduces widely used video encoders
designed to provide bitstreams compressed according to their respective
standards. The most well-known video encoders are the open-source x264 and x265
encoders, which are compelling implementations of their underlying standards
(H.264 and H.265). Google’s open-source libvpx encoder implements VP9, while the
SVT-AV1 production encoder is the most well-known open source video encoder for
AV1. Also covered in this section are proprietary encoders, such as Eve-VP9 and
Eve-AV1.

### **2.1.1 Existing Video Compression Standards (Codecs)** {#2.1.1-existing-video-compression-standards-(codecs)}

Video compression standards, also known as video codecs (shortened from “video
encoder/decoder), are technical specifications that define how video data is
compressed and decompressed to reduce file size by discarding data that is not
considered perceptually salient (Ibraheem et al., 2024). These standards are
crucial for broadcasting, streaming, and storing video information efficiently
(Ibraheem et al., 2024).

H.264/AVC (Advanced Video Coding) is a royalty-bearing video standard popular on
the modern Web that sees almost completely ubiquitous decoding support across
most consumer hardware used to stream video. Jointly developed by the ITU-T
Video Coding Experts Group (VCEG) and the ISO/IEC Moving Picture Experts Group
(MPEG) H.264 was finalized around 2003 (Wiegand et al., 2003). H.264 became
popular quickly, and it significantly improved coding efficiency compared to
earlier standards like MPEG-2, achieving approximately a 50% bit-rate savings
for equivalent perceptual quality (Wiegand et al., 2003). It enabled digital
video in various applications, including broadcast HD TV, camcorders, Blu-ray
Discs, and most notably internet/mobile video (Sullivan et al., 2012). Key
features include variable block-size motion compensation (down to 4x4),
quarter-sample-accurate motion compensation, weighted prediction, and an in-loop
deblocking filter to reduce artifacts (Wiegand et al., 2003). Alongside its core
lossy compression techniques, it introduced a Network Abstraction Layer (NAL)
unit syntax structure for robust and flexible transport over various networks
(Wiegand et al., 2003). H.264 features strong lossless compression techniques as
well; Context Adaptive Binary Arithmetic Coding (CABAC) and Context-Adaptive
Variable-Length Coding (CAVLC) are used for enhanced entropy coding, helping
increase the efficiency of both lossy and lossless video compression. H.264/AVC
remains the dominant video codec in production, with 79% of surveyed video
professionals using it (The Annual Bitmovin Video Developer Report, 2025).

H.265/HEVC (High Efficiency Video Coding) serves as another royalty-bearing
standard meant to succeed H.264/AVC, developed by the same joint groups and
finalized in 2013 (Sullivan et al., 2012). Its primary goal was to achieve
significantly improved compression performance, targeting around a 50% bit-rate
reduction for the same perceptual quality relative to H.264/AVC, especially for
high-resolution video. This was especially relevant due to a perceived increase
in demand for higher video resolution (e.g., 4K and 8K) (Sullivan et al., 2012).
To overcome one of H.264’s weakest points for high resolution video, H.265
introduced Coding Tree Units (CTUs), which are larger block structures (up to
64x64 luma samples) that enable better compression particularly for
high-resolution content (Sullivan et al., 2012). H.265 also incorporates an
Adaptive Sample Offset (SAO) filter in the decoding loop to better reconstruct
signal amplitudes (Sullivan et al., 2012). Generally speaking, HEVC requires
more computing resources than H.264/AVC but tends to achieve higher video
quality for the same encoding parameters (Matha et al., 2021). Alongside the
video standard, HEIF (High Efficiency Image Format) utilizes HEVC intra-frame
compression techniques for image compression (Ibraheem et al., 2024).

VP9 is an open-source video codec launched and deployed by Google in mid-2013
(Mukherjee et al., 2013). It offered competitive coding efficiency with HEVC and
significantly outperformed H.264/AVC and its predecessor, VP8. VP9 was used as
the basis for the development of AV1, a modern royalty-free video standard meant
to surpass both H.265 and H.264 (Chen et al., 2018). It is commonly used for
streaming high-definition video over networks with limited capacity.

AV1 (AOMedia Video 1\) is an open-source and royalty-free video compression
format, jointly developed and finalized in early 2018 by the Alliance for Open
Media (AOMedia) (Chen et al., 2018). Its main goal is to achieve substantial
compression gain over state-of-the-art codecs while maintaining practical
decoding complexity and hardware feasibility (Chen et al., 2018). It offers an
average bitrate reduction of almost 30% compared to the most performant open
source VP9 encoder at the same quality (Chen et al., 2018). AV1 introduces
advanced compression tools such as color palette prediction for artificial
videos, a more powerful inter coder with extended reference frame pools, and
dynamic spatial and temporal motion vector referencing (Chen et al., 2018). It
allows for flexible transform unit partitioning and defines a richer set of
transform kernels (including DCT, ADST, flipADST, and IDTX) (Chen et al., 2018).
AV1 utilizes a symbol-to-symbol adaptive multi-symbol arithmetic coder, which is
more efficient to decode compared to traditional binary arithmetic coding for
elements with larger alphabets (Chen et al., 2018). AV1 also adds loop
restoration filters (like the Wiener filter) and a frame super-resolution coding
mode for in-loop upscaling (Chen et al., 2018). A unique feature offered by AV1
is film grain synthesis, which removes difficult-to-compress grain before
encoding and synthesizes it at the decoder, theoretically providing a
significant reduction in bitrate for grainy content (Chen et al., 2018).
Perpetual optimism for AV1 adoption exists due to its compression performance
(approximately 50% less data than H.264/AVC and 30% less than H.265/HEVC and
VP9), but its widespread implementation has lagged due to slower rollout of
playback and decoding support (The Annual Bitmovin Video Developer Report,
2025).

_Figure 2: Processing stages of an AV1 encoder with relevant technologies
associated with each stage – by Luc Trudeau, CC BY 4.0._

H.266/VVC (Versatile Video Coding) is the modern successor to HEVC, released in
2020 (Katsenou et al., 2020). It is designed to provide approximately 50%
bitrate reduction compared to HEVC at the same perceptual quality (Ibraheem et
al., 2024). VVC employs cutting-edge coding methods, including improved motion
prediction, adaptive loop filtering, and increased entropy coding (Ibraheem et
al., 2024). Like AV1, VVC is computationally more demanding and takes longer to
encode, and hardware decoder support is almost non-existent (Ibraheem et al.,
2024).

While traditional codecs have incrementally improved, a new frontier is emerging
with AI-based codecs, particularly Neural Video Compression (NVC) frameworks
(Wang et al., 2024). Although these experimental codecs show promise in research
settings, they are not yet practical for the production-oriented scope of this
paper. NVC frameworks often require complex, multi-stage training processes and
lack the widespread, mature hardware and software decoder support essential for
large-scale delivery (Wang et al., 2024). Their computational and implementation
complexities currently outweigh their benefits for most real-world business
applications, which require stability, speed, and broad compatibility (Wang et
al., 2024). For these reasons, while the field of AI-based codecs is
interesting, it remains outside the scope of production-oriented video
implementations with immediate business value.

### **2.1.2 Video Encoder Implementations** {#2.1.2-video-encoder-implementations}

Many video codecs have various software and hardware implementations. This paper
will focus on software implementations, which have been used by the majority of
livestreaming and video-on-demand workflows for the past couple of years (The
Annual Bitmovin Video Developer Report, 2025).

x264 is an open source H.264/AVC encoder. It is the most widely used encoder for
H.264/AVC. x264 is deployed by over 90% of the video streaming industry as of
2021 (Matha et al., 2021). It is generally considered to have a faster speed
ceiling than most other open source encoders. In performance analysis on Amazon
EC2 instances, x264 shows cases where Arm instances can achieve faster encoding
times and lower costs compared to x86 instances, especially for certain presets
and bitrates (Matha et al., 2021).

libvpx is an open-source software video encoder released by Google, implementing
an encoder for both the VP8 and VP9 video codecs (Chen et al., 2018). It is
commonly used for performance comparisons involving VP9, as it is the reference
implementation of the VP9 codec (Chen et al., 2018).

x265 is a widely used software encoder for encoding video into the H.265/HEVC
format (Chen et al., 2018). It is known for achieving high efficiency, but can
be computationally intensive. It is open-source, and developed primarily by
Multicoreware. It is maintained under the GNU GPL v2 software license.

SVT-AV1 (Scalable Video Technology for AV1) is an optimized open-source encoder
implementation for AV1 developed by members of the Alliance for Open Media
alongside open source contributors, specifically for CPU platforms. It is
designed for production use cases, and borrows from the open-source reference
AV1 encoder (called libaom) maintained by Google. SVT-AV1 emphasizes
quality-latency tradeoffs and supports advanced parallelism features. From
tested codecs and configurations, SVT-AV1 provides the best tradeoff between
energy consumption and quality (Katsenou et al., 2022). Its encoding energy
consumption is considered to be better than other AV1 implementations (Katsenou
et al., 2022).

VVenC/VVdeC are open-source, optimized implementations of the VVC encoder and
decoder for random-access high-resolution video encoding. VVenC is designed to
achieve faster runtime than the VVC reference software (VTM) and supports
multi-threading and rate control (Katsenou et al., 2022). In terms of perceptual
quality (BD-VMAF), VVenC/VVdeC generally offers the highest gains compared to
x265 (Katsenou et al., 2022).

This section would be incomplete without covering proprietary video encoders and
open-source offerings. The most noteworthy proprietary video encoders that offer
concrete performance claims are Eve-VP9 and Eve-AV1 by Two Orioles, LLC. Eve-VP9
claims to provide “nearly 20% better compression than libvpx at the same speed”
or “10% better compression than x265 at 50% faster speed”. Compared to x264,
Eve-VP9 is “nearly 40% better.” (Two Orioles LLC, 2025). Eve-AV1 makes similar
claims, offering “a 20% reduction in bitrate at the same visual quality compared
to other AV1 encoders” or alternatively “a 3 to 5 times speedup in encoding
time.” (Two Orioles LLC, 2025). These claims would put Eve-VP9 in the same
performance category as SVT-AV1, despite VP9 being a much older codec. While we
cannot externally validate these claims, the company provides numbers on their
website for a more complete comparison to other encoders.

While the sources offer claims regarding software encoder performance, the
methodology section of this paper will involve benchmarking rate-distortion
trade-offs for these different encoders to assess their most recent performance.
Video encoder development happens rapidly, and a number of open-source encoders
have claimed impressive gains since the sources last covered their performance.

### **2.1.3 Metrics to Quantify Video Fidelity** {#2.1.3-metrics-to-quantify-video-fidelity}

Quantifying video fidelity is crucial for evaluating compression algorithms,
optimizing encoding, and ensuring a good Quality of Experience (QoE) for viewers
(Rassool, 2017). Effective visual fidelity metrics allow this to happen at
scale, and also provide a means of comparing video encoders to one another.

Subjective Evaluation (Mean Opinion Score \- MOS / Differential Mean Opinion
Score \- DMOS) is considered the most accurate method for assessing human
perception of video quality (Li et al., 2016). Collecting MOS/DMOS scores
involves human observers providing ratings, typically on a scale (e.g., 1 to 5
for impairment) (Li et al., 2016). DMOS scores are derived from these subjective
ratings and often normalized (e.g., 0-100) (Li et al., 2016). The obvious
downside is that subjective testing is time-consuming, expensive, and not
feasible for real-time monitoring at scale (Li et al., 2016).

Peak Signal-to-Noise Ratio (PSNR) is a traditional signal quality metric derived
from Mean Squared Error (MSE) (Rassool, 2017). Two of the clearest benefits to
using PSNR are that it is simple to calculate and it has clear physical meanings
(Wang and Bovik, 2009). Despite its widespread use as a de facto standard for
codec comparisons, PSNR is known to correlate poorly with human perception of
video quality (Helmrich et al., 2020). Practically speaking, this means that
videos with similar PSNR values can have vastly different perceived qualities.
Higher PSNR values generally indicate better quality (Ibraheem et al., 2024).
PSNR is often reported for individual color components. The luminance component
error is reported by PSNR-Y, blue-chroma (chrominance blue) is reported by
PSNR-Cb, and red-chroma (chrominance red) is PSNR-Cr (Chen et al., 2018).

Structural Similarity Index (SSIM) and Multi-Scale SSIM (MS-SSIM) are more
complex visual fidelity metrics meant to succeed PSNR. Introduced in 2004, SSIM
is an image quality metric that aims to measure structural distortion,
correlating better with human perception than PSNR (Wang et al., 2004). It
computes a score based on local patterns of pixel intensities, normalized for
luminance and contrast. MS-SSIM is an extension that processes images at
multiple scales (Rassool, 2017). SSIM can be applied to video by computing
scores frame-by-frame and then averaging them (Wang and Bovik, 2009). While
performing better than PSNR, SSIM and MS-SSIM are more algorithmically complex
compared to basic PSNR (Helmrich et al., 2020\)

Netflix developed Video Multi-Method Assessment Fusion (VMAF) as a
full-reference perceptual video quality metric that aims to approximate human
perception of video quality (Li et al., 2016). It combines multiple elementary
quality metrics (e.g., Visual Information Fidelity (VIF), Detail Loss Metric
(DLM), and a simple Motion feature) using a machine-learning algorithm (Support
Vector Machine regressor) (Li et al., 2016). VMAF focuses on quality degradation
specifically due to compression and scaling artifacts, and it exhibits a higher
correlation with perceptual quality compared to PSNR (Katsenou et al., 2022).
While more effective than other options, VMAF is algorithmically complex and not
differentiable, which limits its use for direct perceptual control in encoding
processes (Helmrich et al., 2020). Netflix utilizes VMAF to evaluate video
codecs, encoding parameters, and for automated quality control in their pipeline
(Li et al., 2020). A VMAF score around 93 is suggested as an optimal target for
high viewer satisfaction (Rassool, 2017).

Extended WPSNR (XPSNR) is a relatively new metric, released in 2020 (Helmrich et
al., 2020). WPSNR is an improvement over PSNR that uses a block-wise perceptual
weighting of the Mean Squared Error (MSE) based on spatial activity (Helmrich et
al., 2020). XPSNR is an extension of WPSNR designed to address shortcomings with
video and Ultra High-Definition (UHD) content (Helmrich et al., 2020). It
incorporates a low-complexity temporal visual activity model, modifies frame
averaging to a square-mean-root approach, and uses spatial downsampling for UHD
content to improve correlation with subjective judgments (Helmrich et al.,
2020). XPSNR aims to match the performance of state-of-the-art methods like
(MS-)SSIM and VMAF while maintaining very low computational complexity and being
usable for decision-making within video encoders (Helmrich et al., 2020).

Bjøntegaard Delta (BD-Rate/BD-PSNR/BD-VMAF) is not a metric, but rather a method
used to compare the overall rate-quality (RQ) performance of different video
codecs or encoding configurations (Barman et al., 2022). A negative BDRate
signifies that a codec achieves the same quality while using fewer bits (i.e.,
better compression efficiency) (Chen et al., 2018).

Standards and metrics are continuously evolving to meet the increasing demand
for high-quality, high-resolution video content while optimizing for storage,
bandwidth, and energy consumption. To compare video encoder performance, rate
distortion graphs can be constructed comparing size to video fidelity. Based on
the rate distortion curves graphed using data from different encoders, the
BD-rate can be computed between them. If also measuring time to encode, one can
then construct a BD-rate to time graph, showing the ratio of speed (or energy
consumption) to compression efficiency across a wide breadth of encoder
performance targets.

## **2.2 Video Delivery and Cost Management** {#2.2-video-delivery-and-cost-management}

Video streaming companies utilize various infrastructure models and strategies
to deliver content efficiently and provide high-quality user experiences
(Darwich et al., 2017). The commonly used models have evolved over time, driven
by factors like increased demand for high-resolution content and HDR, diverse
viewing conditions, and network bandwidth constraints (Li et al., 2018).

### **2.2.1. Core Components and Their Functions** {#2.2.1.-core-components-and-their-functions}

The process of delivering video content online involves several key
infrastructure components. Content Preparation (Encoding & Transcoding) is the
first of these components; on a fundamental level, encoding is the
transformation of raw video content into a digital format suitable for online
delivery (The Annual Bitmovin Video Developer Report, 2025). Transcoding is the
process of converting a video to different formats or characteristics (e.g.,
frame rate, resolution, video codec, bit rate) supported by various viewer
devices (Darwich et al., 2017). This is a computationally intensive and
time-consuming operation. Video streams are commonly split into Group Of
Pictures (GOPs) for independent processing and transcoding (Li et al., 2018).
Initial encoding prepares source video data by compressing it at a chosen
resolution, frame rate, key frame interval, and video bitrate. A transcoding
pipeline then re-encodes a video stream with different specifications, such as
creating multiple bitrate versions (Roy, 2025). Modern video codecs like
H.264/AVC, H.265/HEVC, VP9, and AV1 are used to achieve higher compression
efficiency, as the previous section discussed. Newer codecs generally offer
efficiency gains at the cost of increased computational complexity for encoding
(Katsenou et al., 2022).

Video Stream Providers (VSPs) are charged for storage services based on the
volume of their data stored in the cloud, typically on a monthly basis (Darwich
et al., 2017).

Content Delivery Networks (CDNs) are widely used to deliver transcoded streams
by storing identical content in different geographical areas, which helps reduce
network delay and minimizes network travel time to users (Darwich et al., 2017).
CDNs are also used to offload origin servers and reduce download latency
(Stockhammer, 2011). CDN services are typically not applied when providing
on-demand video transcoding services directly (Darwich et al., 2017). HTTP-based
streaming (e.g., Dynamic Adaptive Streaming over HTTP (DASH)) enables easy and
effortless streaming by avoiding NAT and firewall traversal issues, provides
reliability, and deployment simplicity, and allows the use of standard HTTP
servers and caches, including CDNs (Stockhammer, 2011). Streaming formats like
HLS (HTTP Live Streaming) and DASH are widely adopted, with CMAF (Common Media
Application Format) emerging as a way to alleviate encoding and storage costs by
acting as a container for both (Menon et al., 2023).

The media player is the only part of the video tech stack that end users
typically interact with. Companies often support various platforms and devices,
including HTML5 in browsers, native mobile applications, and Smart TVs (The
Annual Bitmovin Video Developer Report, 2025).

There is a trend away from purely Do-It-Yourself (DIY) player development
towards hybrid or commercial solutions, as open-source players have been
reported to require roughly double the maintenance time compared to commercial
solutions (The Annual Bitmovin Video Developer Report, 2025).

Video analytics solutions (e.g., Google Analytics, Bitmovin Analytics) are used
to collect data on streaming performance, identify root causes of quality
issues, and monitor viewer engagement (The Annual Bitmovin Video Developer
Report, 2025).

### **2.2.2. Key Infrastructure Models and Strategies** {#2.2.2.-key-infrastructure-models-and-strategies}

Streaming companies adopt different models to handle the immense computational
and storage demands (Darwich et al., 2017). Many VSPs extensively utilize cloud
computing services to overcome the computational demands of transcoding.
Netflix, for example, encodes its video streams in a distributed cloud-based
media pipeline to scale to business needs (Li et al., 2016).

Cloud providers like Amazon EC2 offer a large portfolio of heterogeneous Virtual
Machines (VMs) optimized for specific purposes (e.g., General-Purpose,
CPU-Optimized, GPU-Optimized, Memory-Optimized) (Matha et al., 2021). Different
transcoding operations have varying affinities with different VM types (Li et
al., 2018).

Companies evaluate "build versus buy" decisions for their streaming
infrastructure, weighing the cost savings of in-house solutions over time
against the efficiency and specialization offered by outsourced service
providers and CDNs (Li et al., 2018). Outsourcing is common for specialized IT
functions like media serving (Rayburn & Hoch, 2005).

The latest trends show an increase in software encoding in public clouds,
potentially due to cost savings, while hardware encoder appliances on-premises
remain standard for live streaming (The Annual Bitmovin Video Developer Report,
2025). There is also a move towards using multiple third-party CDN services
rather than in-house CDNs, driven by convenience and scalability (The Annual
Bitmovin Video Developer Report, 2025).

Depending on the model a streaming company embodies, they must choose between
pre-transcoding and on-demand (and partial) transcoding. Pre-transcoding
involves transcoding and storing multiple formats of the same video in the cloud
off-line to make them readily available (e.g., Netflix pre-transcodes 40-50
different formats of a single video) (Darwich et al., 2017). This approach
requires enormous storage space and imposes significant cost. On-demand (lazy)
transcoding (also called re-transcoding) is proposed for infrequently accessed
video streams. In this model, only one or a few formats are stored, and
transcoding is performed on-the-spot when a viewer requests a format that is not
pre-transcoded (Darwich et al., 2017). This approach aims to reduce storage
costs but can incur significant computational costs, which are generally more
expensive than storage on an hourly basis (Darwich et al., 2017). A partial
pre-transcoding method aims to strike a trade-off, pre-transcoding only a
portion of the video (e.g., the frequently accessed beginning segments or GOPs)
and re-transcoding the rest upon request (Darwich et al., 2017). Architectures
like Cloud-based Video Streaming Services (CVS2) are designed for on-demand
video transcoding using heterogeneous cloud services, focusing on robust Quality
of Service (QoS) and cost-efficiency (Li et al., 2018). Dynamic VM provisioning
policies in cloud environments can significantly reduce costs (up to 85%) by
adapting the number and type of VMs to the workload, compared to static
clusters. Netflix uses a "scale up early, scale down slowly" principle for VM
provisioning (Li et al., 2018).

With the emergence of multiple modern video codecs (e.g., AVC, HEVC, AV1),
streaming service providers are often required to encode, store, and transmit
bitrate ladders for each codec separately (Menon et al., 2023). Multi-codec
encoding is essential to achieve the efficiencies of next-generation
technologies while ensuring playback on legacy devices. Energy-efficient schemes
like Multi-Codec Bitrate ladder Estimation (MCBE) aim to reduce energy
consumption by eliminating redundant representations of new-generation codecs
and minimizing perceptual redundancy based on a Just Noticeable Difference (JND)
threshold (Menon et al., 2023).

HTTP Adaptive Streaming (HAS), also known as Adaptive Bitrate (ABR) streaming,
is a widely used technology that encodes video content into multiple
bitrate-resolution pairs. This allows the stream to dynamically adapt to varying
bandwidth fluctuations and viewer device capabilities, ensuring the highest
possible video quality without risking buffering (Matha et al., 2021). This
requires more complex transcoding capabilities (Roy, 2025).

### **2.2.3. Challenges and Emerging Trends** {#2.2.3.-challenges-and-emerging-trends}

The streaming industry faces ongoing challenges, and must continuously research
new improvements to tackle these challenges. Controlling bandwidth and storage
costs is a major challenge, driving significant decisions in the industry (The
Annual Bitmovin Video Developer Report, 2025). Delivering seamless playback
across the enormous number of devices and platforms remains a significant hurdle
as well. Ensuring a consistent and high-quality viewing experience for users,
minimizing issues like buffering, start failures, and latency, is a top priority
(The Annual Bitmovin Video Developer Report, 2025).

Ad insertion has become the top streaming challenge and a major opportunity for
innovation, especially with the rise of ad-supported video-on-demand (AVOD) and
Free Ad-supported Linear TV (FAST) business models. Server-guided ad insertion
(SGAI) is an emerging technology in this field that aims to combine client-side
ad insertion and server-side ad insertion (The Annual Bitmovin Video Developer
Report, 2025).

Content protection is another challenge, and Digital Rights Management (DRM)
solutions are becoming increasingly complex and more widely adopted to protect
sensitive corporate information and commercial content (The Annual Bitmovin
Video Developer Report, 2025).

While energy consumption has not historically been a primary optimization target
for video companies, there is a growing awareness of environmental costs. New
codecs increase computational complexity, driving research into more
energy-efficient encoding and streaming solutions (Katsenou et al., 2022).

AI and machine learning technologies are increasingly used to optimize efficient
encoding schemes, enhance perceptual quality measurement, and improve user
experience through applications like audio transcription, video tagging,
categorization, and recommendations (Ibraheem et al., 2024). While machine
learning has yet to establish a foundational place embedded within major video
standards, it has propagated throughout the streaming industry as a deeply
valuable tool for improving other parts of the video delivery pipeline.

While it follows much of the same practices illustrated so far, it is worth
mentioning that there is a growing trend in the distribution and consumption of
short-form and user-generated content, which requires adjusted encoding and
delivery approaches (The Annual Bitmovin Video Developer Report, 2025).

## **2.3 Implementations and Providers** {#2.3-implementations-and-providers}

Video streaming companies leverage a variety of providers and solutions for
their infrastructure needs, ranging from cloud services and content delivery
networks to specialized encoding tools and analytics platforms.

Amazon Web Services (AWS) is a major cloud provider that offers computational
services through a large portfolio of heterogeneous Virtual Machines (VMs),
including General-Purpose, CPU-Optimized, GPU-Optimized, Memory-Optimized,
Storage-Optimized, and Dense-Storage VMs (Li et al., 2018). They also offer
Content Delivery Network (CDN) services (Darwich et al., 2017).

Bitmovin is a leading video encoding company that provides cloud-native software
solutions for flexible and scalable media encoding, playback, and analytics
(Matha et al., 2021\) Its encoding platform is built atop the MPEG-DASH open
standard over multiple cloud instances (Matha et al., 2021). Bitmovin’s
Analytics service is provided as a commercial video analytics solution to help
measure user interactions to improve engagement and user satisfaction (The
Annual Bitmovin Video Developer Report, 2025). Various video analytics providers
include Google Analytics, NICE PEOPLE AT WORK (NPAW), Mux, Conviva, Touchstream,
Mediamelon, and Datazoom (The Annual Bitmovin Video Developer Report, 2025).
Bitmovin supports the use of multiple or single third-party CDN services, and
hybrid CDN models (The Annual Bitmovin Video Developer Report, 2025).

Two Orioles, LLC provides specialized video encoders such as Eve-AV1, an AV1
encoder that offers either bitrate reduction at the same visual quality or
faster encoding time (Two Orioles, 2025). They also offer Eve-VP9 for optimizing
VP9 video compression. Encoders are offered under a subscription model, and the
company provides ongoing support to clients (Two Orioles, 2025).

Netflix operates its own distributed cloud-based media pipeline for encoding
video streams (Li et al., 2016). Netflix developed and open-sourced the VMAF
Development Kit (VDK), a software package for perceptual video quality metrics,
which they integrate into their encoding pipeline for automated quality control
(Li et al., 2016).

The Alliance for Open Media (AOMedia) is a consortium of over 30 leading
high-tech companies, including Google and Apple, working collaboratively to
develop next-generation open, royalty-free video coding formats such as AV1
(Chen et al., 2018).

Wowza Video is a comprehensive streaming solution that provides transcoding
capabilities to prepare video for various bitrates, platforms, and devices,
supporting both live and Video On Demand (VOD) content (Roy, 2025).

EZDRM is a commercial Digital Rights Management (DRM) provider for content
protection (The Annual Bitmovin Video Developer Report, 2025).

The company Keynote offers Streaming Perspective, a Web-based automated service
that measures the quality and reliability of streaming media delivery from the
end-user perspective, providing reports on buffering delays or broken links
(Rayburn & Hoch, 2005).

CCBN is a webcasting communications company that offers virtual meetings and
provides outreach and tracking services for investor relations (Matha et al.,
2021).

In addition to these, certain software tools and platforms (some open source)
are integral to streaming infrastructure. FFmpeg is the cornerstone of much of
the world’s streaming infrastructure, and serves as an open-source multimedia
multi-tool (Matha et al., 2021).

## **2.4 Streaming Companies** {#2.4-streaming-companies}

Video streaming has become a common practice, and currently accounts for the
vast majority of internet traffic with projections indicating further growth
(Darwich et al., 2017). This rise is driven by various services, including
on-demand streaming platforms like Netflix and YouTube and live video
conferencing. Meeting the increasing demands for higher resolutions and quality
requires efficient video processing (Katsenou et al., 2022).

### **2.4.1 Video Streaming Business Models** {#2.4.1-video-streaming-business-models}

Video On Demand (VOD) services, such as YouTube and Netflix, require videos to
be converted (transcoded) to match the diverse characteristics of viewers'
devices, including frame rate, resolution, and network bandwidth (Li et al.,
2018). Providers commonly pre-transcode and store multiple formats of the same
video in the cloud to make them readily available. However, this approach
demands enormous storage space and can be costly, especially given that many
videos are rarely accessed (Darwich et al., 2017). Thus, cost-efficient
repository management is crucial for VOD.

Similar to VOD, live content needs to be transcoded to suit viewer devices (Li
et al., 2018). A primary challenge is maintaining low latency (Roy, 2025).
Technologies like SRT (Secure Reliable Transport) are gaining traction in live
contribution feeds, signaling a shift from older protocols like RTMP. WebRTC is
also increasing for low-latency streaming (The Annual Bitmovin Video Developer
Report, 2025). Live streaming at scale is a growing challenge, potentially due
to live sports content moving from linear broadcast to streaming delivery.

### **2.4.2 Categorizing Viewer Access Patterns** {#2.4.2-categorizing-viewer-access-patterns}

Especially pertinent in today’s landscape featuring short-form content,
companies must consider whether they serve long-tail content or Frequently
Accessed Videos (FAVs).

Viewer access patterns for user generated content often follow a long-tail
distribution, meaning a small percentage of videos are accessed frequently,
while a large portion is rarely accessed (Darwich et al., 2017). For these
rarely accessed videos, companies propose on-demand (lazy) transcoding (also
called re-transcoding) using cloud computing services to reduce storage costs.
Re-transcoding incurs computational costs, which are generally more expensive
than storage on an hourly basis in the cloud. Therefore, this approach is most
beneficial for rarely accessed videos (Darwich et al., 2017).

For frequently accessed videos (FAVs), pre-transcoding is generally preferred as
re-transcoding them repeatedly would significantly increase costs (Darwich et
al., 2017). Some methods propose partially pre-transcoding videos by identifying
a "GOP threshold" (GOPth), where GOPs (Group Of Pictures) before the threshold
are pre-transcoded and those after it are re-transcoded. This is based on the
observation that beginning segments of a video are watched more frequently
(Darwich et al., 2017).

### **2.4.3 Operational Needs and Challenges** {#2.4.3-operational-needs-and-challenges}

The primary challenge for any streaming company is Quality of Experience (QoE),
or Quality of Service (QoS) (The Annual Bitmovin Video Developer Report, 2025).
Minimizing startup delay and presentation deadline violations is crucial for
viewer satisfaction (Li et al., 2018). Additionally, maintaining consistent
quality and minimizing issues like buffering/rebuffering rates and error rates
are top priorities (Rayburn & Hoch, 2005). Relevant perceptual video metrics
like VMAF help to maintain high quality video at the lowest transmission cost
possible (Li et al., 2016).

Video transcoding requires significant storage and computational resources, so
cost efficiency is another key concern for streaming companies. Due to the costs
incurred, many providers are driven to use cloud services (Darwich et al.,
2017). Cloud computing services offer VMs (Virtual Machines) with diverse
architectural configurations and varying prices, allowing for cost optimization.
Companies can dynamically provision heterogeneous VM clusters to balance cost
and QoS (Li et al., 2018). Encoding, storage, and transmission of multiple
bitrate ladders (different resolutions/qualities for adaptive streaming) for
various codecs result in substantial computational workload and energy
consumption (Menon et al., 2023). Strategies to eliminate redundant
representations can significantly reduce these costs (Menon et al., 2023).
In-house solutions for encoding, DRM, CDNs, and players are being edged out by
commercial services, likely due to increased flexibility and sophistication of
commercial offerings and cost savings cloud encoding can deliver (The Annual
Bitmovin Video Developer Report, 2025).

In pursuit of optimal efficiency to transmit video streams at the lowest
bitrate, compression efficiency (and thus more efficient video codecs) have
become more of a focus for streaming companies. Advanced video codecs such as
H.264/AVC, HEVC, VP9, AV1, and VVC are critical for reducing file sizes and
enabling streaming at reasonable bitrates (Menon et al., 2023). Each new
generation of codec typically offers improved efficiency; it takes time for
newer encoders to mature and overcome initially increased computational
complexity (Katsenou et al., 2022). H.264/AVC remains the dominant codec
overall, but there is a clear trend towards next-generation codecs, even if
their adoption is slower than anticipated due to playback and decoding support
rollout (The Annual Bitmovin Video Developer Report, 2025). The implementations
used to encode H.264 vary, but the high-efficiency open source x264 encoder is
owed in part for H.264’s success.

Adaptive Bitrate Streaming (ABR) helps companies serve video more efficiently by
allowing video to adapt to varying bandwidth conditions and device capabilities
(Roy, 2025). Content is encoded into multiple bitrate-resolution pairs (encoding
ladder). The client can then dynamically switch between these streams based on
network conditions (Roy, 2025). A Multi-Codec Bitrate Ladder Estimation (MCBE)
scheme aims to optimize these ladders by eliminating redundant representations
and minimizing perceptual redundancy based on a Just Noticeable Difference (JND)
threshold, leading to energy savings (Menon et al., 2023).

The increasing demand for higher quality video and complex codecs contributes to
increased energy consumption in data centers and display devices, which is both
a monetary and sustainability concern for streaming companies (Katsenou et al.,
2022). While video streaming companies optimize for quality, energy consumption
becomes more of a focus when compute is more expensive. SVT-AV1 has been shown
to provide a good trade-off between energy consumption and quality (Katsenou et
al., 2022).

Another concern for streaming companies is copyright protection, which is where
Content Protection and Digital Rights Management (DRM) come in. DRM security
technology is essential to protect streaming and digital media content, allowing
content creators to charge for their content and enabling business models like
subscriptions (Rayburn & Hoch, 2005). Implementing DRM is complex, with a
growing trend towards using commercial DRM providers over in-house solutions
(The Annual Bitmovin Video Developer Report, 2025).

Measuring the quality of experience for viewers is crucial to improving it,
which is why accurate and reliable intelligence on audience consumption habits
is crucial for a streaming business’s success (Rayburn & Hoch, 2005). This
includes tracking unique visitors, content downloads, simultaneous connections,
viewing duration, and player types (Rayburn & Hoch, 2005). Video analytics tools
are used to ensure stable, reliable playback, though identifying the root cause
of streaming issues can still be time-consuming. Key performance metrics include
error rates, rebuffering rates, and video latency (The Annual Bitmovin Video
Developer Report, 2025),

## **2.5 Conclusion** {#2.5-conclusion}

The proliferation of internet video, projected to constitute the vast majority
of web traffic, has made the optimization of video delivery a critical issue for
both economic and environmental sustainability. This review has established that
while advanced video compression technologies offer a powerful solution, the
selection of an optimal codec and encoder is still a complex decision that
extends far beyond technical metrics. While newer standards promise significant
reductions in bitrate, they come with the trade-off of increased encoding
complexity and challenges in ecosystem adoption.

Choosing a specific software implementation further complicates the
decision-making process. Evaluating their performance requires a shift from
traditional metrics like PSNR, which correlates poorly with human perception, to
more advanced, perceptually-driven metrics such as VMAF. The use of Bjøntegaard
Delta rate (BD-rate) calculations provides a standardized method for comparing
the rate-quality efficiency between different encoding solutions.

Ultimately, the technical decision of which compression technology to adopt is
intrinsically linked to an organization's business model and economic realities.
The operational costs of the video delivery pipeline encompassing transcoding,
storage, and CDN-based distribution are significant drivers of business
strategy. Companies must weigh the trade-offs between pre-transcoding content
for immediate availability versus on-demand transcoding to save storage costs, a
decision heavily influenced by whether they serve frequently accessed videos or
long-tail user-generated content.

This paper has laid the groundwork for a data-driven framework that bridges this
gap between technical performance and business value. By leveraging
Rate-Distortion analysis as a foundational metric and integrating it with
crucial business factors such as computational cost, licensing fees, and codec
maturity, this research aims to provide organizations with a quantifiable
methodology. Such a framework will enable businesses of various sizes to make
informed strategic decisions that align their video compression strategy with
their specific economic constraints and long-term objectives in an increasingly
video-dominated internet landscape.

# **Chapter 3: Methodology** {#chapter-3:-methodology}

This study will employ a multi-stage methodology to evaluate video encoding
strategies. The process begins with a rigorous technical analysis of encoder
performance and progressively integrates economic cost factors to derive
tailored recommendations for distinct video streaming business models.

## **3.1 Introduction** {#3.1-introduction}

### **3.1.1 Software Encoder Evaluation** {#3.1.1-software-encoder-evaluation}

The initial step is to establish a technical performance baseline for a
selection of modern video codecs and their software implementations. We will be
testing a representative set of widely-used open-source encoders, including
x264, x265, SVT-AV1, libaom, and libvpx-vp9. Our test corpus is a standard test
set sourced from Netflix Open Content clips, and overlaps the AOM Common Test
Conditions v2.0. The nineteen clips are sourced from Netflix’s Chimera and
Netflix’s El Fuente, and represent industry-standard test conditions. Each clip
will be encoded using each selected encoder. For each encoder, a range of speed
presets (from the fastest to the slowest practical setting) will be tested. At
each speed preset, encodes will be generated at various quality levels to
produce a full rate-distortion curve. For every encoded video, various metrics
(including SSIM, PSNR, VMAF, VMAF-NEG, and XPSNR) will be computed alongside the
resulting video file size. The efficiency of each encoder setting will then be
compared using the Bjøntegaard Delta rate (BD-rate) method. This will quantify
the percentage of bitrate savings one encoder provides over another for the same
objective quality; using this, we can build a final graph comparing overall
efficiency to speed, which should give us a thorough and informative evaluation
of our encoders.

### **3.1.2 Computational & Economic Cost Modeling** {#3.1.2-computational-&-economic-cost-modeling}

Technical efficiency is only valuable when placed in an economic context. This
step quantifies the cost associated with each point on the RD curves generated
in the previous step. During each encoder’s telemetry capture in the previous
step, the encoding time will be recorded. Through this, we can derive a single
adaptable metric: efficiency per CPU-hour. This KPI measures how efficiently an
encoder uses computational resources to generate visual quality.

A total cost model will be developed to evaluate a given encoding strategy. The
model will be based on public cloud service pricing (e.g., AWS or Google Cloud)
to ensure relevance and reproducibility.

The Total Cost of Ownership (TCO) for a video asset will be defined as:

TCO=Ctranscode+Cstorage+Cdelivery

Where _Ctranscode​_ (Transcoding Cost) represents the one-time cost to encode the
video. This is calculated from the computational cost data (encoding time
multiplied by price per CPU hour). _Cstorage_​ (Storage Cost) is the ongoing cost
to store the encoded file. This is calculated from the output bitrate (file size
times price per GB/mo). _Cdelivery​_ (Delivery Cost) is the cost to stream the
video to viewers via a Content Delivery Network (CDN). This is calculated from
the file size and the number of views (file size • views • price per GB
transferred).

### **3.1.3 Scenario-Based Analysis for Business Profiles** {#3.1.3-scenario-based-analysis-for-business-profiles}

The core of the methodology is to apply the economic cost model to three
distinct streaming business profiles by adjusting the variables in the TCO
formula, particularly the Views variable.

_Scenario A: Frequently Accessed VOD (e.g., Netflix, Apple TV+, Disney+)_ is a
profile characterized by a curated library where each asset is viewed millions
of times. The model will set the Views variable to a very high number (e.g.,
\>1,000,000). In this scenario, we can expect the _Cdelivery​_ term to dominate
the TCO equation. The analysis will therefore identify the encoding strategy
that produces the lowest possible bitrate for a target quality score (e.g., VMAF
95\) even if it requires extremely high, one-time transcoding costs. The optimal
strategy is to minimize delivery costs at all expense.

The _Scenario B: Long-Tail VOD (e.g., YouTube, TikTok)_ profile is characterized
by a massive user-generated library where the vast majority of videos are viewed
very few times. The Views variable will be set to a low number (e.g., \<100).
Here, the _Ctranscode​_ and _Cstorage_​ terms are the most significant drivers of
cost, as they are incurred for every single uploaded video regardless of
viewership. The analysis will identify the encoding strategy that offers the
best balance between fast encoding speed (low transcode cost) and reasonable
compression (low storage cost). The most efficient, slowest encoders will likely
be impractical here.

_Scenario C: Live Streaming (e.g., Twitch, YouTube Live)_ is defined by the
strict requirement of real-time processing. The analysis will first filter out
any encoding preset where the encoding time is longer than the video's duration
or is slower than the video’s playback speed (implying the video cannot be
processed in real-time). For the remaining real-time-capable encoders, the TCO
will be calculated with Views representing the concurrent viewership. The
primary goal is to find the encoder that provides the lowest bitrate at an
acceptable quality within the real-time speed constraint. This minimizes live
delivery costs while ensuring a stable broadcast.

The final step will be to synthesize the results from the scenario analysis into
a clear, actionable framework. The output will be a set of recommendations
presented in a decision matrix or flowchart. This will guide a streaming company
in selecting a codec, encoder, and speed preset based on their specific business
profile (Frequently Accessed, Long-Tail, or Live), allowing them to balance
quality, cost, and performance effectively.

## **3.2 Evaluating Software Encoders** {#3.2-evaluating-software-encoders}

Evaluating a software encoder across a broad range of performance targets is
optimally done with a sample of representative test media across every speed
preset the encoder makes available. Within each speed preset, the encoder should
be measured at several different data points that represent a wide fidelity
range.

### **3.2.1 Test Conditions** {#3.2.1-test-conditions}

The encoders I evaluated in this test include:

- x264, a production-oriented H.264 encoder
- x265, a production-oriented H.265 encoder
- SVT-AV1, a production-oriented AV1 encoder
- libaom (aomenc), the reference implementation of the AV1 codec
- libvpx (vpxenc), the reference implementation of the VP8 & VP9 codecs

I did not test vpxenc’s VP8 performance, as VP8 compatibility has dwindled over
time in favor of VP9.

The sample clips I used for this test were sourced from Netflix Open Content
lossless uncompressed video clips, which were sourced as 10-bit 4K files at
around 10 seconds each. In order to allow my samples to be representative of
widely distributed video content as well as to allow testing to conclude within
a reasonable time, I downscaled each clip to 1080p with Catmull-Rom downscaling.
I also reduced the framerate of each clip to 30 frames per second while
preserving each clip’s duration.

The Netflix Open Content lossless clips I sourced from were as follows:

1. Aerial
2. Crosswalk
3. FoodMarket
4. RitualDance
5. ToddlerFountain
6. BarScene
7. Dancers
8. FoodMarket2
9. RollerCoaster
10. TunnelFlag
11. Boat
12. DinnerScene
13. Narrator
14. SquareAndTimelapse
15. WindAndNature
16. BoxingPractice
17. DrivingPOV
18. PierSeaside
19. Tango

To sample the performance of each encoder across all 19 clips, I sampled from
five quality values for each encoder for a given speed preset. For each quality
value, I measured the quality and bitrate of the resulting encoded clip and the
encoder’s time spent encoding the clip. The quality-to-bitrate ratios were
graphed as points on a graph, forming rate distortion curves that could be
measured against a reference curve from another encoder or speed preset to
produce a BD-rate for this given speed preset (expressed as a percentage
indicating compression efficiency relative to the reference). This process was
repeated for the relevant speed presets each encoder contained, and the
resulting BD-rates were graphed relative to the aforementioned time to encode
for each speed preset. From this data, we produce a graph that contains
quality-to-speed curves for each encoder we tested.

Various graphs can be produced using this method for different metrics. We
computed the following metrics:

- PSNR
- SSIM
- VMAF
- VMAF-NEG (Harmonic Mean)
- XPSNR

All of this was efficiently scripted through the “Metrics” open-source toolkit
provided by the “Psychovisual Experts Group.” The only modification made was to
use libvmaf’s built-in AOM CTC mode to emulate the Alliance for Open Media’s
Common Test Conditions when reporting SSIM & PSNR instead of FFmpeg’s built-in
implementations. The tools are provided in Python, and were called iteratively
through the Bash script included in the annex.

Version information is provided below:

- PSY-EX Metrics: checkout 0993a8a
- FFmpeg: version n7.1.1
- SVT-AV1: v3.0.2-110-gd37b1a57 (release)
- x264: 0.164.3108 31e19f9
- x265: version 4.1
- aomenc: 3.12.1-207-ga72dbc44c9
- vpxenc: v1.15.0
- libvmaf: version 3.0.0

### **3.2.2 Preliminary Test Results** {#3.2.2-preliminary-test-results}

Graphs are included below.

![][image3]

_Figure 3: Software encoder efficiency after our testing with the PSNR metric._

![][image4]_Figure 4: Software encoder efficiency after our testing with the
SSIM metric._

![][image5]_Figure 5: Software encoder efficiency according to our testing with
the VMAF metric._

![][image6]_Figure 6: Software encoder efficiency according to our testing with
the VMAF NEG metric, averaging frames using the harmonic mean instead of the
arithmetic mean._

![][image7]_Figure 7: Software encoder efficiency according to our testing with
the XPSNR metric._

![][image8]_Figure 8: Software encoder efficiency according to our testing,
averaging BD-Rates from PSNR, SSIM, & VMAF._

The graphs all use a logarithmic horizontal scale factor to better illustrate
the differences between encoder speeds. A curve further to the bottom left means
a more efficient encoder, as a negative BD-Rate value indicates bitrate savings
expressed as a percentage.

A table showcasing the information visualized in each graph is provided in the
annex.

Based on this information, we can begin making extrapolations for the next
section related to cost modeling.

## **3.3 Computational & Economic Cost Modeling** {#3.3-computational-&-economic-cost-modeling}

The technical evaluation in the previous section provides a clear picture of the
relative compression efficiency and speed of various encoders. However, for a
streaming service provider, these technical metrics only tell part of the story.
The decision to adopt a specific encoding strategy must be grounded in economic
context, translating efficiency percentages into operational costs. This section
develops a cost model to bridge the gap between technical performance and
business value, quantifying the financial implications of different encoding
choices.

The core of this model is to move beyond simple speed measurements and evaluate
how efficiently an encoder utilizes computational resources to achieve
compression. We can derive an adaptable metric, efficiency per CPU-hour, which
measures the BD-rate savings achieved for every hour of computation. This allows
for a direct comparison of the return on investment for transcoding time.

To build a comprehensive economic picture, we define a Total Cost of Ownership
(TCO) model for a single video asset. This model aggregates the primary costs
associated with the lifecycle of a video file in a typical cloud-based streaming
workflow. The TCO is defined by the following formula:

TCO=Ctranscode+Cstorage+Cdelivery

_Ctranscode_​ (Transcoding Cost) is the one-time, upfront cost incurred to encode
the video. It is calculated by multiplying the measured Time to Encode from our
tests by the price of a compute instance in a public cloud. This cost is
directly proportional to the slowness of the chosen encoder preset.

_Cstorage_​ (Storage Cost) is the recurring cost to store the compressed video
file. It is calculated from the output bitrate (which determines file size) and
the provider's price per gigabyte per month (GB/month). More efficient encoders,
which produce smaller files, directly reduce this cost.

_Cdelivery​_ (Delivery Cost) is the cost to stream the video to viewers via a
Content Delivery Network (CDN). It is calculated by multiplying the file size by
the number of views and the price per gigabyte of data transferred. This cost is
often the most significant expense for popular content and is also directly
reduced by better compression.

To illustrate this model, we can apply it to our full test data, using realistic
public cloud pricing through AWS. AWS costs scale differently with usage,
region, compute hardware capability, compute hardware architecture, and more.
For the purposes of this comparison, some realistic figures can be extrapolated
for a moderately sized organization in the business of streaming video. Prices
acquired as of July 2025\.

- Extrapolated Compute Cost: $0.05 per CPU-hour (Amazon, 2025\)
- Extrapolated Storage Cost: $0.023 per GB-month (Amazon, 2025\)
- Extrapolated Delivery (CDN) Cost: $0.08 per GB transferred (Amazon, 2025\)

The table below applies this model to our test clips, extrapolating the costs to
represent a one-hour video. The XPSNR metric is used for quality comparison,
with the x264 slow preset serving as our baseline (0.00% BD-Rate). This analysis
will allow us to profile each video encoder’s performance and discuss how
cost-savings can be incurred depending on the encoder utilized. Note that vpxenc
and aomenc encoders had several speed presets that produced identical results;
for brevity, only distinct presets are shown.

### **3.3.1 x264 Costs** {#3.3.1-x264-costs}

Using the "slow" preset as a baseline for comparison, the data shows a clear
trade-off: faster presets like "ultrafast" have a very low transcoding cost
($0.017 per video-hour) but produce a high bitrate (9.219 Mbps), leading to the highest delivery costs ($331.90
per 1000 views). Conversely, moving to slower presets increases the transcoding
time and cost but significantly reduces the bitrate, which in turn lowers
storage and delivery expenses. The "slower" preset, for example, has a higher
transcode cost
($0.056) but achieves a lower bitrate (3.847 Mbps) and the cheapest delivery cost ($138.48)
within the x264 family.

### **3.3.2 x265 Costs** {#3.3.2-x265-costs}

The x265 encoder demonstrates a significant improvement over the x264 baseline.
Every tested preset offers better compression efficiency (a negative XPSNR
BD-Rate), resulting in lower bitrates and reduced delivery costs compared to
x264's "slow" preset. The "ultrafast" x265 preset is faster and cheaper to
transcode than the x264 "slow" baseline while still providing a slightly lower
delivery cost. As with x264, investing more time in transcoding by using slower
presets yields substantial savings on delivery; the "slower" x265 preset has a
very high transcoding cost ($0.561) but reduces the delivery cost to just $89.03
per 1000 views.

### **3.3.3 SVT-AV1 Costs** {#3.3.3-svt-av1-costs}

SVT-AV1 showcases state of the art speed and efficiency; even its faster presets
offer significant bitrate savings compared to the x264 baseline. For instance,
preset 8 (p08) is more than twice as fast to encode as x264 "slow" but still
reduces delivery costs by over 11%. The slowest SVT-AV1 preset tested (p02)
provides the best compression in this group, cutting delivery costs by half
compared to the baseline ($72.18 vs. $144.00), though it demands a higher
upfront transcoding cost of $0.228 per video-hour.

### **3.3.4 vpxenc Costs** {#3.3.4-vpxenc-costs}

This table details the performance of the vpxenc (VP9) encoder’s non-redundant
presets. Both presets are considerably slower to encode than the x264 baseline,
resulting in high transcoding costs ($0.159 and $0.175 per video-hour). In
return for this high computational expense, they offer good compression
efficiency, leading to meaningful reductions in delivery costs compared to the
baseline. However, it is clear that this is not a versatile encoder; comparisons
to the production-oriented encoders we’ve already tested are not particularly
favorable considering x264 is faster while SVT-AV1 is generally more efficient
across the board.

### **3.3.5 aomenc Costs** {#3.3.5-aomenc-costs}

The aomenc (AV1) reference encoder represents the extreme end of the
efficiency-versus-speed spectrum. Its presets are orders of magnitude slower
than the x264 baseline, leading to substantial transcoding costs ranging from
$0.207 to $1.717 per video-hour. However, this computational effort yields the
highest compression efficiency of all tested encoders. Speed 3 achieves a
remarkable \-50.81% BD-Rate, producing the lowest bitrate and the cheapest
potential delivery cost of $70.83 per 1000 views. This encoder is also a
reference encoder, and this fact is clearly displayed in its lack of
flexibility; it is only financially viable in scenarios with extremely high
viewership where delivery savings can offset the massive initial transcoding
expense.

### **3.3.6 Encoder Costs Summary**

The data reveals stark economic trade-offs expected of Internet video streaming.
While offering excellent compression at their slowest settings, vpxenc & aomenc
come with prohibitively high transcoding costs. This makes them clearly
impractical for most reasonable use cases, though aomenc could potentially
provide value when facing vast view counts for certain videos. In contrast, the
production-oriented SVT-AV1 encoder demonstrates its value by providing
significant bitrate savings at a transcoding cost that, while high, is an order
of magnitude lower than the reference encoder. Even SVT-AV1's faster presets are
much quicker than the x264 slow baseline while still offering meaningful bitrate
savings. The numbers for x265 also show a clear pattern that investing more in
transcoding time increases the transcode cost dramatically while reducing
delivery costs.

This cost breakdown provides the quantitative foundation necessary for the
scenario-based analysis in the following section. By adjusting the number of
views variable within this framework, we can simulate how the optimal encoding
strategy changes dramatically for different business profiles.

## **3.4 Scenario-Based Analysis for Business Profiles**

The Total Cost of Ownership (TCO) model provides a powerful framework for moving
beyond purely technical metrics to make economically sound decisions about video
encoding. The optimal strategy is not universal; it shifts dramatically based on
a service's business model and content distribution patterns. This section
applies the TCO model to three distinct business profiles (Frequently Accessed
VOD, Long-Tail VOD, and Live Streaming) to illustrate how different viewership
patterns dictate the ideal balance between transcoding cost, storage cost, and
delivery cost.

The formula to compute the cost of using an encoder’s preset is as follows:

TCO=Ctranscode• R+Cstorage• R+Cdelivery• V

Where _R_ represents our library size and _V_ represents the aggregate number of
views during the one-month video retention period. We will assume for the sake
of simplicity that all videos are uploaded at the beginning of the storage
payment period and retained for a month while viewership takes place, and that
costs related to cloud services stay fixed during this time.

Based on the business profile, we can assume different values for _R_ and _V_.

### **3.4.1 Scenario A: Frequently Accessed VOD**

This profile is defined by a curated library of high-quality content where each
video asset is expected to be viewed millions of times. In this scenario, the
_Cdelivery_ component of the TCO formula becomes the overwhelmingly dominant
factor. The one-time transcoding cost, even if substantial, is amortized over a
massive number of views, making it negligible in comparison to the cumulative
cost of delivery.

The primary goal is to achieve the lowest possible bitrate for a target quality
level to minimize data transfer costs at scale. In order to benchmark different
video encoders, we used x264’s “slow” preset as a baseline; now, we can
understand that baseline relative to other encoders. For experimentation with
Scenario A, we will assume a catalogue of 10,000 videos viewed 10,000,000 times
in aggregate.

When viewership is high, investing in the most computationally intensive and
efficient encoder pays significant dividends. The slowest encoder in our testing
was aomenc using preset 3\. Looking at the TCO produced by this encoder, we see
it is $85,640.22 for this use case; in this instance, $10,808.67 of our cost was
incurred by transcoding, which is a mere 12.62% of our total cost. The
overwhelming majority of the cost here is transmission, so the lowest TCO is
produced by aomenc due to its superior compression and subsequent delivery
savings. Overall, for a frequently accessed VOD provider, choosing a fast but
inefficient encoder can be financially catastrophic over an asset's lifecycle;
choosing aomenc’s preset 6 nets a TCO of $89,981.95, which is worse despite the
encoder being over eight times faster than at preset 3\.

Preset 3 happens to be the best for our particular test bench because it
produces the best BD-rate, and is therefore the most compression efficient
encoder configuration in our test suite. There are even slower presets available
through aomenc, and SVT-AV1’s slowest configurations are potentially competitive
there as well.

### **3.4.2 Scenario B: Long-Tail VOD**

This profile represents user-generated content (UGC) platforms with enormous
libraries where the vast majority of videos are viewed infrequently, if at all.
Views per video are very low on average, so the economic drivers are the upfront
_Ctranscode_​​ and recurring _Cstorage_ costs as these are incurred for every
uploaded video regardless of its popularity. The potential savings on
_Cdelivery_ are minimal and cannot justify a high initial transcoding cost. The
goal is to find an encoder that is fast (to minimize _Ctranscode_​​) and provides
reasonable compression (to minimize _Cstorage_).

For this scenario, we assume 100,000 videos that are viewed 10,000 times. We can
assume there are no technical hurdles barring us from lowering view count below
the number of videos uploaded because existing services see this pattern already
(e.g. a cloud photo storage application that transcodes a video for viewership
on secondary devices, but shows users their original locally-stored video upon
playback on the primary device).

The optimal configuration here is SVT-AV1 preset 8, which nets us a TCO of
$6,516.14. Transcoding is over a quarter of our incurred cost, while storage is
the most expensive component here. Transmission costs end up being the least
significant contribution to TCO. In this scenario, the slowest encoders (like
aomenc and slow/slower x265 presets) are economically impractical. Within
SVT-AV1, if we move to preset 7 to attempt to save on storage our transcoding
costs increase by almost 50% and we end up eliminating the gains we would have
achieved through storage savings.

### **3.4.3 Scenario C: Live Streaming**

Live streaming introduces a hard, non-negotiable constraint: encoding must
happen in real-time. For our 10-second test clips, any encoder preset that takes
longer than 10 seconds to process the clip is automatically disqualified. Within
this real-time constraint, the goal is to find the encoder that provides the
best compression to minimize delivery costs to all concurrent viewers.

Assuming these constraints are correct, we would see that SVT-AV1 p04 offers the
best compression efficiency among all real-time capable presets, resulting in
the lowest delivery cost. However, its encoding time of 9.65 seconds for a
10-second clip leaves a razor-thin margin of error. Any fluctuation in system
performance or content complexity could cause the encoder to fall behind,
leading to dropped frames and a catastrophic failure of the live stream.

This highlights the core complexity of live streaming. Reliance on software
encoders running on general-purpose CPUs is inherently risky. The intense,
sustained CPU load required for real-time video encoding can lead to system
instability and is highly inefficient from a power-consumption standpoint.
Dedicated hardware encoders are often the more practical and reliable solution
for professional live broadcasting. While they may not always match the absolute
compression efficiency of the best offline software encodes, their consistent,
low-latency performance and lower power draw provide the stability and
predictability that are paramount in a live environment. For live streaming,
reliability often trumps marginal gains in compression.

# **Chapter 4: Conclusion**

This research set out to bridge the gap between the technical evaluation of
video compression technologies and their real-world economic implications for
streaming service providers. By systematically benchmarking a suite of modern,
production-oriented software encoders and applying a Total Cost of Ownership
(TCO) model, we have demonstrated that the optimal encoding strategy is not a
one-size-fits-all solution. Instead, it is a nuanced decision deeply intertwined
with a company's specific business model and content distribution patterns.

## **4.1 Summary of Findings**

Our analysis of the x264, x265, SVT-AV1, vpxenc (VP9), and aomenc (AV1) encoders
revealed clear and consistent performance hierarchies. The results, measured
across multiple perceptual quality metrics (VMAF, SSIM, XPSNR), confirm the
generational improvements in compression efficiency.

### **4.1.1 General Encoder Performance**

As expected, the AV1 encoders (SVT-AV1 and aomenc) consistently delivered the
highest compression efficiency, achieving significant bitrate reductions (up to
\~50% BD-rate savings) compared to the x264 (H.264) baseline. The x265 (H.265)
encoder occupied a middle ground, offering a substantial improvement over x264
but falling short of the AV1 implementations. However, this efficiency comes at
a steep computational cost.

The reference encoders, aomenc and vpxenc, were orders of magnitude slower than
the production-oriented SVT-AV1, rendering them impractical for many commercial
applications despite their impressive compression capabilities. SVT-AV1 stands
out as a highly versatile solution, offering a remarkable balance of speed and
efficiency that makes the benefits of AV1 accessible for production workflows.

An important finding from the encoder performance comparison is the significant
performance difference between various encoders for the same codec. While
comparing x264 to x265 involves comparing both encoders and formats, SVT-AV1 and
aomenc can be compared within the same AV1 video codec. This underscores the
critical importance of selecting the appropriate encoder for a given use case,
particularly for organizations operating at scale. For instance, a company
processing large volumes of user-generated content might experience a lack of
obvious value creation with AV1 using aomenc, potentially leading to a negative
perception of AV1. In the future, a clear distinction between a standard's
reference encoder and its production encoder may become imperative if these
issues are prevalent for businesses.

### **4.1.2 Codec Compatibility and Market Adoption**

While newer codecs like AV1 demonstrate superior technical performance, H.264
(encoded by x264) remains the de facto industry standard due to its ubiquitous
hardware decoding support across virtually all consumer devices. This creates a
critical tension: adopting a more efficient codec like AV1 can drastically
reduce delivery costs, but it requires a multi-codec strategy to ensure reach.
The cost of storing and managing multiple versions of each video file must be
factored into the TCO, tempering the raw efficiency gains of next-generation
codecs.

## **4.2 Extrapolations and Future Codecs**

The performance trajectory observed in our tests allows for informed speculation
about the future of video compression.

### **4.2.1 Proprietary Encoders**

Companies like Two Orioles claim their proprietary encoders (e.g., Eve-AV1) can
offer a 20% bitrate reduction over other AV1 encoders or a 3-5x speedup. Our
findings suggest such gains are plausible. The significant performance gap
between aomenc and SVT-AV1 proves that substantial improvements can be achieved
through software engineering and algorithmic optimization, even within the same
codec standard. Proprietary solutions have the potential to leverage specialized
algorithms and tuning that may give them a competitive edge, albeit at the
additional cost of licensing fees and potential vendor lock-in.

### **4.2.2 Future Standards (VVC and Beyond)**

The successor to HEVC, H.266/VVC, promises another \~50% reduction in bitrate.
Based on the evolutionary pattern, we can anticipate that initial VVC encoders
will be computationally demanding, similar to the early days of AV1. However, as
with SVT-AV1, we can expect the development of optimized production encoders
that (given they receive enough resources) make VVC practical for commercial use
over time. The long-term challenge will remain ecosystem adoption, as widespread
hardware decoder support is the ultimate gatekeeper for any new codec's success.

## **4.3 Future Research Directions**

This study opens several avenues for future investigation.

### **4.3.1 Hardware Encoders**

Our analysis focused exclusively on software encoders running on CPUs. A
comparative study incorporating dedicated hardware encoders (e.g., NVIDIA NVENC,
Intel Quick Sync Video) would provide a more complete picture, especially for
the Live Streaming scenario where consistent, low-latency performance is
paramount.

### **4.3.2 Energy Consumption**

As data center operational costs and environmental concerns grow, energy
efficiency is becoming a critical KPI. Future work should explicitly measure and
model the energy consumption of different encoding strategies to quantify the
"green" ROI of more efficient codecs. While a measure such as “watts per frame”
scales almost perfectly with time to encode, delineating this measure to
accentuate its importance may provide value.

### **4.3.3 Diverse Content Types**

Our test set consisted of natural, cinematic video. An analysis using more
diverse content, such as animation, sports, and screen recordings (e.g., video
game streaming), would reveal how encoder performance varies, as different
codecs have tools specifically designed for certain types of content.

### **4.3.4 AI-Based Codecs**

While currently experimental, Neural Video Compression (NVC) frameworks
represent a paradigm shift. Future research should monitor their maturation and,
once practical, benchmark them against traditional codecs to evaluate their
potential to disrupt the current landscape.

## **4.4 Concluding Remarks**

The decision of which video compression technology to deploy is a strategic one
with profound financial consequences. Our scenario-based analysis highlights the
core takeaway: for Frequently Accessed VOD services, the massive scale of
delivery costs justifies investing in the most computationally expensive,
highest-efficiency encodes possible. Conversely, for Long-Tail VOD platforms
like YouTube where most content is rarely viewed, fast and inexpensive
transcoding is the priority. Live Streaming presents a unique challenge where
real-time constraints and reliability often favor the stability of hardware
encoders over the marginal efficiency gains of the slowest software presets.

Ultimately, this paper provides a quantitative framework for navigating these
complex trade-offs. By moving beyond simple technical metrics and embracing a
holistic view that integrates computational cost, storage, delivery, and
business model, organizations can make data-driven decisions that optimize their
video delivery pipeline for both quality of experience and economic
sustainability in an internet landscape increasingly dominated by video.
