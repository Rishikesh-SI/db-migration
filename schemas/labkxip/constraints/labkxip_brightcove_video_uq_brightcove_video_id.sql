-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_brightcove_video uq_brightcove_video_id
-- Type: CONSTRAINT

-- Name: labkxip_brightcove_video uq_brightcove_video_id; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_brightcove_video
    ADD CONSTRAINT uq_brightcove_video_id UNIQUE (brightcove_video_id);


--
