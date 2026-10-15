-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labmi_v1_bkp.labmi_v1_template_component_map USING btree (template_id);


--
