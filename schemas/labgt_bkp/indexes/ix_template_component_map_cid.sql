-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labgt_bkp.labgt_template_component_map USING btree (component_id);


--
