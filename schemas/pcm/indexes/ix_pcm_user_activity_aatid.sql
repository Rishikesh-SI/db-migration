-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_user_activity_aatid
-- Type: INDEX

-- Name: ix_pcm_user_activity_aatid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_user_activity_aatid ON pcm.pcm_user_activity USING btree (asset_id, asset_type_id);


--
