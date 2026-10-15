-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_entity_role_etid
-- Type: INDEX

-- Name: ix_cfc_entity_role_etid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_entity_role_etid ON cfc.cfc_entity_role USING btree (entity_type_id);


--
