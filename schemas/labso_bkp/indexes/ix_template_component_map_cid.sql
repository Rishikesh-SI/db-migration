-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labso_bkp.labso_template_component_map USING btree (component_id);


--
