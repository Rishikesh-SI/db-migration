-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: idx_brightcove_video_sync_status
-- Type: INDEX

-- Name: idx_brightcove_video_sync_status; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX idx_brightcove_video_sync_status ON labkxip.labkxip_brightcove_video USING btree (sync_status);


--
