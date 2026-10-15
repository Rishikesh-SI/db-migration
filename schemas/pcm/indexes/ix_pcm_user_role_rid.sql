-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_user_role_rid
-- Type: INDEX

-- Name: ix_pcm_user_role_rid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_user_role_rid ON pcm.pcm_user_role USING btree (role_id);


--
