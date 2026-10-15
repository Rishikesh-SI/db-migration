-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_is_status_flag
-- Type: INDEX

-- Name: ix_is_status_flag; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_is_status_flag ON labmi_v1.labmi_v1_product_cart_paydetails USING btree (is_status_flag);


--
