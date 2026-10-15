-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_video_upload labpkl_video_upload_id
-- Type: CONSTRAINT

-- Name: labgt01_v1_video_upload labpkl_video_upload_id; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_video_upload
    ADD CONSTRAINT labpkl_video_upload_id PRIMARY KEY (video_upload_id);


--
