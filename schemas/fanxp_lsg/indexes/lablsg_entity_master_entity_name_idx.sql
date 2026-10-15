-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_entity_master_entity_name_idx
-- Type: INDEX

-- Name: lablsg_entity_master_entity_name_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_entity_master_entity_name_idx ON fanxp_lsg.lablsg_entity_master USING btree (entity_name);


--
