-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_role_etid
-- Type: INDEX

-- Name: ix_kxp_entity_role_etid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_role_etid ON labkxp.labkxp_entity_role USING btree (entity_type_id);


--
