-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labal_nassr.labal_nassr_template_component_map USING btree (component_id);


--
