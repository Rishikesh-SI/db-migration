-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labkkr_30012024.labkkr_template_component_map USING btree (template_id);


--
