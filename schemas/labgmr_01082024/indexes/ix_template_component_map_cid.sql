-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labgmr_01082024.labgmr_template_component_map USING btree (component_id);


--
