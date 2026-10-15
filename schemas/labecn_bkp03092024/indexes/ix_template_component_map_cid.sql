-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp03092024
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labecn_bkp03092024; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labecn_bkp03092024.labecn_template_component_map USING btree (component_id);


--
