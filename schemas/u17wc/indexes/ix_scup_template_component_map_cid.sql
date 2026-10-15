-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_template_component_map_cid
-- Type: INDEX

-- Name: ix_scup_template_component_map_cid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_template_component_map_cid ON u17wc.u17wc_template_component_map USING btree (component_id);


--
