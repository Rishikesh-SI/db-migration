-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labmao_bkp.labmao_template_component_map USING btree (component_id);


--
