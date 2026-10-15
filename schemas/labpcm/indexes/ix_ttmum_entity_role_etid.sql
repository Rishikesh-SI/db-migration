-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labpcm.labpcm_entity_role USING btree (entity_type_id);


--
