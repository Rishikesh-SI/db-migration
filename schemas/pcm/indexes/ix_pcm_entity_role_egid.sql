-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_role_egid
-- Type: INDEX

-- Name: ix_pcm_entity_role_egid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_role_egid ON pcm.pcm_entity_role USING btree (entity_group_id);


--
