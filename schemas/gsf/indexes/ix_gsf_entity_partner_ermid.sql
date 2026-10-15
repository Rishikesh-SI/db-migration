-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_entity_partner_ermid
-- Type: INDEX

-- Name: ix_gsf_entity_partner_ermid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_entity_partner_ermid ON gsf.gsf_entity_partner USING btree (entity_role_map_id);


--
