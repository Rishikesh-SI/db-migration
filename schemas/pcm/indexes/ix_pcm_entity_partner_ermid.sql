-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_partner_ermid
-- Type: INDEX

-- Name: ix_pcm_entity_partner_ermid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_partner_ermid ON pcm.pcm_entity_partner USING btree (entity_role_map_id);


--
