-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_role_etid
-- Type: INDEX

-- Name: ix_pcm_entity_role_etid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_role_etid ON pcm.pcm_entity_role USING btree (entity_type_id);


--
