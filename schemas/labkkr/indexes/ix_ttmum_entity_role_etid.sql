-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labkkr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labkkr.labkkr_entity_role USING btree (entity_type_id);


--
