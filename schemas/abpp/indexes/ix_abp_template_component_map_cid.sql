-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_template_component_map_cid
-- Type: INDEX

-- Name: ix_abp_template_component_map_cid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_template_component_map_cid ON abpp.abp_template_component_map USING btree (component_id);


--
