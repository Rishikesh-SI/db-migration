-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_pc_id
-- Type: INDEX

-- Name: ix_pc_id; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_pc_id ON labmi_v1.labmi_v1_product_cart USING btree (product_id);


--
