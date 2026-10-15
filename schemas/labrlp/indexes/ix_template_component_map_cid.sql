-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labrlp.labrlp_template_component_map USING btree (component_id);


--
