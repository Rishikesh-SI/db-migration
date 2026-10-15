-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_role_etid
-- Type: INDEX

-- Name: ix_jafc_entity_role_etid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_role_etid ON jafc.jafc_entity_role USING btree (entity_type_id);


--
