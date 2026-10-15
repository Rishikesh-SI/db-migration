-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labboost.labboost_entity_partner USING btree (entity_role_map_id);


--
