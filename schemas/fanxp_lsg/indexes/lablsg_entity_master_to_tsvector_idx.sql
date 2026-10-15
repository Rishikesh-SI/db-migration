-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_entity_master_to_tsvector_idx
-- Type: INDEX

-- Name: lablsg_entity_master_to_tsvector_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_entity_master_to_tsvector_idx ON fanxp_lsg.lablsg_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
