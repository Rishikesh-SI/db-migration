-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labsrk.labsrk_entity_role USING btree (entity_type_id);


--
