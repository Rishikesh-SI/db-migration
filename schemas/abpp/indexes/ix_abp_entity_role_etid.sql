-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_role_etid
-- Type: INDEX

-- Name: ix_abp_entity_role_etid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_role_etid ON abpp.abp_entity_role USING btree (entity_type_id);


--
