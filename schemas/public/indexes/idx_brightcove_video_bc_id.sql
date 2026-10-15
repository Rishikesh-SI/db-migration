-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: idx_brightcove_video_bc_id
-- Type: INDEX

-- Name: idx_brightcove_video_bc_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_brightcove_video_bc_id ON public.brightcove_video USING btree (brightcove_video_id);


--
