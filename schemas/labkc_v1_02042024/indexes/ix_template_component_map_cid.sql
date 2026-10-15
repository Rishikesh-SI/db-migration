-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labkc_v1_02042024.labkc_v1_template_component_map USING btree (component_id);


--
