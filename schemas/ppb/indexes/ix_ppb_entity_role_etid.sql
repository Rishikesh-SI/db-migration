-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_role_etid
-- Type: INDEX

-- Name: ix_ppb_entity_role_etid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_role_etid ON ppb.ppb_entity_role USING btree (entity_type_id);


--
