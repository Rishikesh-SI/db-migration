-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_pc_id
-- Type: INDEX

-- Name: ix_pc_id; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_pc_id ON labmi.labmi_product_cart USING btree (product_id);


--
