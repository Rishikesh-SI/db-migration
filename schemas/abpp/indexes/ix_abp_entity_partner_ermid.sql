-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_partner_ermid
-- Type: INDEX

-- Name: ix_abp_entity_partner_ermid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_partner_ermid ON abpp.abp_entity_partner USING btree (entity_role_map_id);


--
