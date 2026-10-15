-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labrstg.labrstg_entity_role USING btree (entity_type_id);


--
