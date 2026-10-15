-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labkc_v1.labkc_v1_template_component_map USING btree (template_id);


--
