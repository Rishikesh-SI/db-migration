-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labgmr_01082024.labgmr_template_component_map USING btree (template_id);


--
