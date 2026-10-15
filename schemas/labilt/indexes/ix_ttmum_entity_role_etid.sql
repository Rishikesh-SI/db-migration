-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labilt.labilt_entity_role USING btree (entity_type_id);


--
