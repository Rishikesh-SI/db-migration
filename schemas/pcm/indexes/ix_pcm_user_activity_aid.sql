-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_user_activity_aid
-- Type: INDEX

-- Name: ix_pcm_user_activity_aid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_user_activity_aid ON pcm.pcm_user_activity USING btree (user_id);


--
