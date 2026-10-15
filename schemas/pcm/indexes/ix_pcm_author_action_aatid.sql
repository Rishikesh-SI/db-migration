-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_author_action_aatid
-- Type: INDEX

-- Name: ix_pcm_author_action_aatid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_author_action_aatid ON pcm.pcm_author_action USING btree (asset_id, asset_type_id);


--
