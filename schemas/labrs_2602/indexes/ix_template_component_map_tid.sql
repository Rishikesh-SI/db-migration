-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labrs_2602.labrs_template_component_map USING btree (template_id);


--
