-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_entity_role_etid
-- Type: INDEX

-- Name: ix_kxp_entity_role_etid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_entity_role_etid ON kxp.kxp_entity_role USING btree (entity_type_id);


--
