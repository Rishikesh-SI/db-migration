-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_video_upload labpkl_video_upload_id
-- Type: CONSTRAINT

-- Name: labadkr_video_upload labpkl_video_upload_id; Type: CONSTRAINT; Schema: labadkr_beta; Owner: -
--

ALTER TABLE ONLY labadkr_beta.labadkr_video_upload
    ADD CONSTRAINT labpkl_video_upload_id PRIMARY KEY (video_upload_id);


--
