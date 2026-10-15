-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labmi_v1_bkp.labmi_v1_entity_role USING btree (entity_type_id);


--
