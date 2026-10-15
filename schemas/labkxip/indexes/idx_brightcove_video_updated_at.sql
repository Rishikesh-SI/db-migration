-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: idx_brightcove_video_updated_at
-- Type: INDEX

-- Name: idx_brightcove_video_updated_at; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX idx_brightcove_video_updated_at ON labkxip.labkxip_brightcove_video USING btree (brightcove_updated_at);


--
