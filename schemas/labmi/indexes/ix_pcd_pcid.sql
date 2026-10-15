-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_pcd_pcid
-- Type: INDEX

-- Name: ix_pcd_pcid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_pcd_pcid ON labmi.labmi_product_cart_details USING btree (product_cart_id);


--
