-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labwis.labwis_entity_role USING btree (entity_type_id);


--
