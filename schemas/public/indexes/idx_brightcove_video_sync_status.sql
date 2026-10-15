-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: idx_brightcove_video_sync_status
-- Type: INDEX

-- Name: idx_brightcove_video_sync_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_brightcove_video_sync_status ON public.brightcove_video USING btree (sync_status);


--
