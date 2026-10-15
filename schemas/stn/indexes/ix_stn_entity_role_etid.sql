-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_role_etid
-- Type: INDEX

-- Name: ix_stn_entity_role_etid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_role_etid ON stn.stn_entity_role USING btree (entity_type_id);


--
