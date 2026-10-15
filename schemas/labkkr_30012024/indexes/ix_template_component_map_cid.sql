-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labkkr_30012024.labkkr_template_component_map USING btree (component_id);


--
